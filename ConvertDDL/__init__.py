import re

def command_envelope(sql):
    table_name = re.search(r'.*create +table +(\w+) *\(', sql, re.I)
    if table_name and table_name.group(1):
        table_name = table_name.group(1)
    else:
        return ''

    return f"""\tIF (NOT EXISTS(SELECT 1 FROM RDB$RELATIONS WHERE RDB$RELATION_NAME = '{table_name}')) THEN
    EXECUTE STATEMENT '{sql.replace('  ', ' ')}';"""

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

def convert(content):
    commands = list(filter(
        lambda l:l,
        content\
        .read()\
        .replace('\n', '')\
        .replace("''", "''")\
        .split(';')))

    return envelope(commands)

