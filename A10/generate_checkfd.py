import re

# ==========================================================================
# The following program parses through a CREATE.sql file
# and returns a a CHECKFD.sql containing generated SQL queries
# to detect functional dependences

# The program assumes the file is in the same format as  the CREATE.sql file
# that came with the project description
# ==========================================================================

# Class used to store all tables from CREATE.sql
class Table:
    def __init__(self):
        self.name = ""
        self.variables = []

# Returns the database name in the currently opened file
# See main_loop()
def get_database_name(file):
    database_name = ""
    while database_name is "":
        line = file.readline()
        if "USE" in line or "use" in line:
            database_name = isolate_database_name(line)
    return database_name

# Returns a list of tables (class defined at top of file) from currently opened file
def generate_tables(file):
    tables = []
    table = Table()
    for line in file:
        if "CREATE TABLE" in line or "create table" in line:
            table = Table()
            table.name = isolate_table_name(line)
        elif is_variable(line):
            var = isolate_var_name(line)
            table.variables.append(var)
        if ");" in line:
            tables.append(table)
    return tables

# Returns true if the line is a variable initialization
# Only supports int, char, varchar, text and date
def is_variable(line):
    var_pattern = re.compile(r'\s*\w*\s((INT)|(int)|(CHAR)|(char)|(VARCHAR)|(varchar)|(TEXT)|(text)|(DATE)|(date))')
    if var_pattern.match(line):
        return True
    else:
        return False

# The following 3 functions isolate the database name, variable name and table name, respectively.
# Assuming their argument line contains it

def isolate_database_name(line):
    return line[4:].split(";")[0]

def isolate_var_name(line):
    return line.split()[0]

def isolate_table_name(line):
    return line[13:].split()[0]

# Creates the CHECKFD.sql file and fills it with functional dependencies
def write_checkfd(file, database_name, tables = [], *args):
    file.write("USE " + str(database_name) + "\n")
    for table in tables:
        for i in range(len(table.variables) - 1):
            for j in range(len(table.variables) - 1 - i):
                file.write(get_fd(table, table.variables[i], table.variables[i + j + 1]))
                file.write(get_fd(table, table.variables[i + j + 1], table.variables[i]))

# Returns a functional dependencies query between 2 variables in a table, in the form of a string
def get_fd(table, var1, var2):
    fd = "SELECT '" + str(table.name) + ": " + str(var1) + " -- > " + str(var2) + "' AS FD, CASE WHEN COUNT(*)=0 THEN 'GILDIR' ELSE 'gildir ekki' END AS VALIDITY\n"
    fd += "FROM(\nSELECT " + str(var1) + "\nFROM " + str(table.name) + "\nGROUP BY " + str(var1) + "\nHAVING COUNT(dISTINCT " + str(var2) + ") > 1\n) X;\n"
    return fd

def main_loop(input_file, output_file):
    file = open(input_file, 'r')
    database_name = get_database_name(file)
    tables = generate_tables(file)
    file.close()
    file = open(output_file, "w+")
    write_checkfd(file, database_name, tables)
    file.close()

main_loop("CREATE.sql", "CHECKFD.sql")




