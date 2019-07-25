n = int(input("length = "))
l1 = list(map(int, input().split()))
max_value = max_count = 0

for value in l1:
    count = l1.count(value)
    if count > max_count:
        max_count = count
        max_value = value

print(max_value)
