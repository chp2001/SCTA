import os
d = '.' 
list_dir = [os.path.join(d, o) for o in os.listdir(d) if os.path.isdir(os.path.join(d,o))] 
for folder in list_dir: 
    print(folder)
    filename = folder[2:] + '_unit.bp'
    f = open(os.path.join(folder, filename))
    contents = f.readlines()
    f.close()
    for i in range(len(contents)):
        line = contents[i]
        if 'RangeCategory' in line:
            print(line)
            position = line.index('RangeCategory')
            category = "'" + line[position + 22:-2]
            #print(category)
            contents.insert(i + 1, ' ' * position + 'WeaponCategory = ' + category + ',\n')
            print(contents[i+1])
    f = open(os.path.join(folder, filename), 'w')
    contents = ''.join(contents)
    f.write(contents)
    f.close()