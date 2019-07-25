n = int(input("n = "))
d1 = {}

for i in range(n):
    string = input()
    if string not in d1:
        d1[string] = 1
    else:
        d1[string] += 1

print(len(d1))
print(*d1.values())
