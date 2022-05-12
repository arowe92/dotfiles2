#!/usr/bin/env python
import sys
import os
os.system("")  # enables ansi escape characters in terminal


BLUE = "\033[94m"
GREEN = "\033[92m"
RED = "\033[91m"
ENDC = "\033[0m"
YELLOW = "\033[93m"

from pathlib import Path
from collections import defaultdict

path = Path.home() / '.zsh_history'
print(path)
lines = set()
counts = defaultdict(lambda: 0)
flags = set()

blacklist = {
    '--',
    '-',
    '--help',
}

command = sys.argv[1] if len(sys.argv) > 1 else None

with open(Path.home() / '.zsh_history', 'rb') as f:
    for line in f.readlines():
        try:
            line = line.decode()
            line = ';'.join(line.split(';')[1:])
            line = line.replace('\n', '')
            line = line.replace('\t', ' ')
            parts = [p for p in line.split(' ') if p.startswith('-') and p not in blacklist]

            if len(parts) == 0:
                continue

            cmd = line.split(' ')[0]

            if command is not None and cmd != command:
                continue

            all = (line, cmd, tuple(parts))
            lines.add(all)

            for p in parts:
                counts[(p, cmd)] += 1

        except Exception:
            continue

for line, cmd, parts in lines:
    for p in parts:
        if (p, cmd) not in flags:
            print(f'{YELLOW}{counts[(p, cmd)]}\t{GREEN}{str(p)}\t{BLUE}{line}{ENDC}')
            flags.add((p, cmd))

