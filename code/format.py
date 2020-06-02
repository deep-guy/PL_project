s1 = int(input("Column 1: "))
s2 = int(input("Column 2: "))
with open("boston_dataset.csv", 'r') as file:
    with open("test_data.csv", 'w') as writefile:
        file.readline()
        for line in file:
            line = line.strip()
            line_lst = line.split(',')
            string = ""
            string = string + str(line_lst[s1]) + ',' + str(line_lst[s2]) + '\n'
            writefile.write(string)
