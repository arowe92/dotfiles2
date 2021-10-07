#[allow(dead_code)]
mod utils;

use crate::utils::{Config as EventConfig, Event, Events};
use legion::*;
use std::{error::Error, io, time::Duration};
use termion::{event::Key, input::MouseTerminal, raw::IntoRawMode, screen::AlternateScreen};
use tui::{
    backend::TermionBackend,
    layout::{Constraint, Direction, Layout, Rect},
    style::Color,
    widgets::{
        canvas::{Canvas, Map, MapResolution, Rectangle, Painter, Shape},
        Block, Borders,
    },
    Terminal,

};

// a component is any type that is 'static, sized, send and sync
#[derive(Clone, Copy, Debug, PartialEq)]
struct Position {
    x: f64,
    y: f64,
    c: Color,
}

#[derive(Clone, Copy, Debug, PartialEq)]
struct Velocity {
    dx: f64,
    dy: f64,
}

struct Time {
    elapsed_seconds: f64,
}

struct Config {
    bounds: Rect,
}

impl Shape for Position {
    fn draw(&self, painter: &mut Painter) {
        if let Some((ux, uy)) = painter.get_point(self.x, self.y) {
            painter.paint(ux, uy, self.c);
        }
    }
}


// a system fn which loops through Position and Velocity components, and reads the Time shared resource
// the #[system] macro generates a fn called update_positions_system() which will construct our system
#[system(for_each)]
fn update_positions(pos: &mut Position, vel: &mut Velocity, #[resource] time: &Time, #[resource] config: &Config) {
    pos.x += vel.dx * time.elapsed_seconds;
    pos.y += vel.dy * time.elapsed_seconds;

    if pos.x < config.bounds.left() as f64 || pos.x > config.bounds.right() as f64
    {
        vel.dx *= -1.0;
    }

    if pos.y < config.bounds.top() as f64 || pos.y > config.bounds.bottom() as f64
    {
        vel.dy *= -1.0;
    }
}

fn main() -> Result<(), Box<dyn Error>> {
    // Terminal initialization
    let stdout = io::stdout().into_raw_mode()?;
    let stdout = MouseTerminal::from(stdout);
    let stdout = AlternateScreen::from(stdout);
    let backend = TermionBackend::new(stdout);
    let mut terminal = Terminal::new(backend)?;

    let mut world = World::default();
    let mut resources = Resources::default();

    resources.insert(Config {
        bounds: Rect::new(0, 0, 100, 100),
    });

    for i in 0..1000 {
        let i2: u8 = i as u8;
        let entity: Entity = world.push((
                Position { x: 50.0, y: 50.0, c: Color::Rgb(255, (i as u8) % 255, 0) },
                Velocity { dx: (i + 10) as f64 / 20., dy: (i - 30) as f64/20. }
            ));
    }
    // push a component tuple into the world to create an entity

    let mut schedule = Schedule::builder()
        .add_system(update_positions_system())
        .build();

    // Setup event handlers
    let config = EventConfig {
        tick_rate: Duration::from_millis(16),
        ..Default::default()
    };
    let events = Events::with_config(config);

    loop {
        terminal.draw(|f| {
            let canvas = Canvas::default()
                // .marker(tui::symbols::Marker::Block)
                .paint(|ctx| {
                    // construct a query from a "view tuple"

                    // this time we have &Velocity and &mut Position
                    let mut query = <&Position>::query();
                    for pos in query.iter(&world) {
                        ctx.draw(pos);
                    }
                })
                .x_bounds([0.0, 100.0])
                .y_bounds([0.0, 100.0]);
            f.render_widget(canvas, f.size());
        })?;

        match events.next()? {
            Event::Input(input) => match input {
                Key::Char('q') => {
                    break;
                }
                _ => {}
            },
            Event::Tick => {
                resources.insert(Time {
                    elapsed_seconds: 0.016,
                });
                schedule.execute(&mut world, &mut resources);
            }
        }
    }

    Ok(())
}
