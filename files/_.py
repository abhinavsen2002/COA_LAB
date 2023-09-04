def write(ib):
    print("assign i[" + str(ib) + "] <= ", end='')
    for i in range(ib):
        print("~x[" + str(i) + "] & ", end='')
    print("x[" + str(ib) + "];")

for i in range(32):
    write(i)