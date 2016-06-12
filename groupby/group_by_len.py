from __future__ import print_function
from collections import defaultdict

def group_by_len(file_name):
    f = open(file_name, 'r')
    d = defaultdict(list)
    for l in f.readlines():
        d[len(l.strip())].append(l)
    return d

for i in range(100):
	print(len(group_by_len('/usr/share/dict/american-english').keys()))