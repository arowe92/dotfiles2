#!/usr/bin/env python
import os
os.system("")  # enables ansi escape characters in terminal

BLUE = "\033[94m"
GREEN = "\033[92m"
RED = "\033[91m"
ENDC = "\033[0m"

from pathlib import Path

path = Path.home() / '.zsh_history'
print(path)
lines = set()

blacklist = {
    '--',
    '--help',
}

with open(Path.home() / '.zsh_history', 'rb') as f:
    for line in f.readlines():
        try:
            line = line.decode()
            line = ';'.join(line.split(';')[1:])
            line = line.replace('\n', '')
            line = line.replace('\t', ' ')
            parts = [p for p in line.split(' ') if p.startswith('--') and p not in blacklist]

            if len(parts) == 0:
                continue

            all = (line, tuple(parts))
            lines.add(all)
        except Exception:
            continue

for cmd, parts in lines:
    for p in parts:
        print(f'{GREEN}{str(p)}\t{BLUE}{cmd}{ENDC}')

