with open('coarse.CELLS.dat','w') as fout:
    for i in range(21341):
        fout.write('{}   1\n'.format(i+1))


