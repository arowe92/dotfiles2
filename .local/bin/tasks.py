#!/usr/bin/env python

import re
import sys
import subprocess as sp
import toml
from pathlib import Path

class Expression:
    VARIABLES = re.compile(r'{(\w+)}')
    ENV_VAR = re.compile(r'{\$(\w+)}')
    SHELL = re.compile(r'{!(\w+)}')
    SPREAD = re.compile(r'{.*|\*}')

def upfind(filename='tasks.toml'):
    paths = []

    path = Path().absolute()
    if not path.is_dir():
        path = path.parent

    while True:
        paths += list(path.glob(filename))
        if path.parent == path:
            break

        path = path.parent

    return list(reversed(paths))

if len(sys.argv) > 1:
    file_type = sys.argv[1]
else:
    file_type = "none"

config = {}

for file in upfind():
    with open(file) as f:
        config = {
            **config,
            **toml.load(f)
        }

tasks = config.get('tasks', {})

def get_task_list(name):
    ret = []
    task_list = tasks.get(name, {})

    if type(task_list) is list:
        ret = [{"name": "cmd", "cmd": v} for v in task_list]

    if type(task_list) is dict:
        ret = [{"name": k, "cmd": v} for k,v in task_list.items()]

    for t in [*ret]:
        if '{bazel_targets}' in t['cmd']:
            ret.remove(t)
            for line in sp.check_output(config['commands']['bazel_targets'], shell=True).decode().split('\n'):
                ret += [
                        {
                            "name": t["name"],
                            "cmd": t['cmd'].replace('{bazel_targets}', line),
                            "alias": line,
                        }
                ]


    return ret

task_list = [
    *get_task_list(file_type),
    *get_task_list('all')
]

B='\x1b[33;3m'
E='\x1b[0m'

task_str = ''
for obj in task_list:
    name = obj['name']
    cmd = obj['cmd']
    alias = cmd if 'alias' not in obj  else obj['alias']
    label= f'{B}{name}:{E} {alias}'
    task_str += ','.join([cmd, label]) + "\n"
    print(f'{cmd},{label}')
