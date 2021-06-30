# Script name: Item Description Generator.
# Author: Agent00C4
# Usage: Place in units directory and run. 
# Creates a unitdscription.lua file 
# with blank descriptions and LOC markers
# Overwrites existing unitdescription.lua in working directory

import os
import string


header = """do\n\n-- TODO: make sure all descriptions are up to date\n\nDescription = table.merged( Description, {\n\n"""

footer = """\n} )\n\nend\n"""

def generateDescription(unitID):
    return "\n    ['{}'] = \"<LOC {}_help>.\"".format(unitID, unitID)


currentDir = '.' 
f = open("unitdescription.lua", "w")

f.write(header)

unitIDs = [Dir.lower() \
 for Dir in os.listdir(currentDir) \
 if os.path.isdir(os.path.join(currentDir,Dir))]

# comma delimit lines and write out each one
f.write(','.join(generateDescription(id) for id in unitIDs))

f.write(footer)

f.close()
