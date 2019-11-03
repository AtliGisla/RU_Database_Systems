from io import open
import re

class Table:
    def __init__(self, name):
        self.name = name
        self.rows = []
        self.keys = []

class Row:
    def __init__(self, name, datatype):
        self.name = name
        self.datatype = datatype

def reducetab(line):
    index = 0
    while line[index] == ' ':
        index += 1
    return line[index:]

def filltable(createfile):
    readtables = []
    creatingtable = False
    newtable = None
    newrow = None
    for line in createfile:
        line = reducetab(line)
        words = line.split(" ")
        #print(words)
        if creatingtable:
            #Add keys
            if words[0] == "PRIMARY" and words[1] == "KEY":
                keys = words[2:]
                for key in keys:
                    newtable.keys.append(re.sub('[(,)\n]', '', key))
            #Complete table and append to tables
            elif words[0] == ");\n":
                #print("FINISHING UP TABLE\n")
                readtables.append(newtable)
                creatingtable = False
            #Add Row
            else:
                newrow = Row(words[0], words[1][:-2])
                newtable.rows.append(newrow)
        #Create new table
        elif words[0] == 'CREATE' and words[1] == 'TABLE':
            #print("CREATING TABLE\n")
            newtable = Table(words[2])
            creatingtable = True
    return readtables

def writescript(tables, scriptfile):
    for table in tables:
        if len(table.keys) == 1:
            pass
        else:
            scriptfile.write("SELECT CASE\n")
            tableandkeys = table.name + ": " + table.keys[0] + "-->"
            for key in table.keys[1:]:
                tableandkeys += (key + ",")
            scriptfile.write("\tWHEN COUNT(*) = 0 THEN '" + tableandkeys + "MAYBE MVD'\n")
            scriptfile.write("\tELSE '" + tableandkeys + "NO MVD'\n")
            scriptfile.write("\tEND\n")
            scriptfile.write("\tAS MVD\n")
            scriptfile.write("FROM (SELECT " + table.keys[0] + "\n")
            scriptfile.write("\tFROM " + table.name + "\n")
            scriptfile.write("\tGROUP BY " + table.keys[0] + "\n")
            scriptfile.write("\tHAVING (COUNT(DISTINCT " + table.keys[1] + ") ")
            if len(table.keys) > 2:
                for key in table.keys[2:]:
                    scriptfile.write("* COUNT(DISTINCT " + key + ") ")
            scriptfile.write("\n")
            scriptfile.write("\t\t<> COUNT(*))\n")
            scriptfile.write(") X;\n\n")

createfile = open("./CREATE.sql", "r")
scriptfile = open("CHECKMVD.sql", "w")
tables = filltable(createfile)

writescript(tables, scriptfile)

createfile.close()
scriptfile.close()


"""
SELECT CASE
    WHEN COUNT(*) = 0 THEN '[table][key1]-->[key2..N]MAYBE MVD'
    ELSE '[table][key1]-->[key2..N]NO MVD'
    END
    AS MVD 
FROM (SELECT [KEY1]
      FROM [TABLE]
      GROUP BY [KEY1]
      HAVING (COUNT(DISTINCT [KEY2]) * COUNT(DISTINCT [KEY3]) 
                   <> COUNT(*))
) X;
"""

"""
for table in tables:
    print("TABLE ", table.name)
    print("ROWS:")
    for row in table.rows:
        print(row.name, row.datatype)
    print("KEYS:")
    printkeys = ""
    for key in table.keys:
        printkeys += key
        printkeys += ", "
    print(printkeys)
    print()
"""
