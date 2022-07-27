
fn main() {
    let out = std::process::Command::new("python3")
        .arg("/home/arowe/dot/test.py")
        .output()
        .expect("bad");

    let s = String::from_utf8(out.stdout).unwrap();
    let idx = s.match_indices("{").next().unwrap().0;
    let idx2 = s.match_indices("}").last().unwrap().0;
    let slice =  &s[idx..=idx2];
    dbg!(slice);
}
