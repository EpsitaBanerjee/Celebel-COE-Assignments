from itertools import groupby

input_string = input()

compressed = [(len(list(group)), int(key)) for key, group in groupby(input_string)]


for item in compressed:
    print(item, end=' ')
