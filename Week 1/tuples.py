n = int(input())


elements = tuple(map(int, input().split()))

result_hash = hash(elements)


print(result_hash)
