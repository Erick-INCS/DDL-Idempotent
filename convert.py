#!/usr/bin/env python3
from sys import argv
import re

argv = argv[1:]

def command_envelope(sql):
    table_name = re.search(r'.*create +table +(\w+) *\(', sql, re.I)
    if table_name and table_name.group(1):
        table_name = table_name.group(1)
    else:
        return ''

    return f"""if (not exists(select 1 from rdb$relations where rdb$relation_name = '{table_name}')) then
    execute statement '{sql}';"""

def envelope(commands):

    if not commands and not len(commands):
        return

    commands = '\n\n'.join(list(map(command_envelope,commands)))

    return f"""
    SET TERM !!;
    EXECUTE block as
    BEGIN

    {commands}

    END!!
    SET TERM ; !!"""

def convert(infile, outfile=''):
    with open(infile, 'rt') as content:
        commands = list(filter(
            lambda l:l,
            content\
            .read()\
            .replace('\n', '')\
            .replace("''", "''")\
            .split(';')))

    commands = envelope(commands)

    if outfile:
        with open(outfile, 'wt') as out:
            out.write(commands)
    else:
        print(commands)


if len(argv) not in [1, 2]:
    print('Syntax: ./convert.py input_file.sql output_file.sql')
else:
    convert(*argv)


