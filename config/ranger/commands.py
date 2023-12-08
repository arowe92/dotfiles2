from ranger.api.commands import Command
import subprocess as sp
import os.path
from pathlib import Path

ARGS = "+m -p -w 40% -h 30% -x 0% -y 100%"

def fzf(cmd):
    try:
        return sp.check_output(f"{cmd} {ARGS}".split(' ')).decode()
    except:
        return ""


class fzf_select(Command):
    def execute(self):
        output = fzf("fzf-ls")

        if output:
            fzf_file = os.path.abspath(output.rstrip('\n'))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)

class fzf_find(Command):
    def execute(self):
        output = fzf("fzf-ls-r")

        if output:
            fzf_file = os.path.abspath(output.rstrip('\n'))
            if os.path.isdir(fzf_file):
                self.fm.cd(fzf_file)
            else:
                self.fm.select_file(fzf_file)

class fzf_fasd_cd(Command):
    def execute(self):
        output = fzf("fzf-fasd-cd")
        if output:
            fzf_file = os.path.abspath(output.rstrip('\n'))
            self.fm.cd(fzf_file)

class fzf_fasd_file(Command):
    def execute(self):
        output = fzf("fzf-fasd-file")
        if output:
            fzf_file = os.path.abspath(output.rstrip('\n'))
            self.fm.select_file(fzf_file)

class fzf_grep(Command):
    def execute(self):
        query = self.arg(1)
        # output = sp.check_output(['rg', query, '--no-heading'], shell=True)
        try:
            output = sp.check_output(f'rg {query} --vimgrep --color=always --no-heading | fzf-tmux --ansi {ARGS}', shell=True).decode()
        except:
            return

        if not output:
            return

        parts = output.split(':')
        self.fm.select_file(parts[0])
        file = Path(parts[0])
        self.fm.execute_command(f'nvim {file.name}:{parts[1]}')


collapsed = False
class collapse(Command):
    def execute(self):
        global collapsed
        collapsed = not collapsed
        if collapsed:
            self.fm.execute_console("set collapse_preview true")
            self.fm.execute_console("set preview_directories false")
            self.fm.execute_console("set preview_files false")
            self.fm.execute_console("set column_ratios 1,3,0")
        else:
            self.fm.execute_console("set collapse_preview true")
            self.fm.execute_console("set preview_directories false")
            self.fm.execute_console("set preview_files true")
            self.fm.execute_console("set column_ratios 1,2,3")


class tmux_split(Command):
    def execute(self):
        global collapsed
        collapse.execute(self)
        if collapsed:
            sp.check_output(["tmux",  "split-window", "-h", "source /home/arowe/.zshrc && nvim_socket"])
        else:
            sp.check_output(["nvr", "--remote-send", "ZZ"])


