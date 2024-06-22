def average(array):
    new_set = set(array)
    avg = sum(new_set)/len(new_set)
    return (avg)
if __name__ == '__main__':
    n = int(input())
    arr = list(map(int, input().split()))
    result = average(arr)
    print(result)