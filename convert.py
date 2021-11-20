#!/usr/bin/env python3
import argparse
from ConvertDDL import convert

argparser = argparse.ArgumentParser(description='SQL file with create statements to an SQL Idempotent script.')
argparser.add_argument('infile', help='Input SQL file.')
argparser.add_argument('outfile', help='Output SQL file.')

def read_and_convert(infile, outfile):
    with open(infile, 'rt') as content:
        commands = convert(content)

    if outfile:
        with open(outfile, 'wt') as out:
            out.write(commands)
    else:
        print(commands)

if __name__ == '__main__':
    args = argparser.parse_args()
    read_and_convert(args.infile, args.outfile)
