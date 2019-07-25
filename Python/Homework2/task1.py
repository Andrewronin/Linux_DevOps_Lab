x = int(input("x = "))
y = int(input("y = "))
z = int(input("z = "))
n = int(input("N = "))

answer = []
p = 0
for i in range(x + 1):
    for j in range(y + 1):
        for k in range(z + 1):
            if (i + j + k) != n:
                answer.append([])
                answer[p] = [i, j, k]
                p += 1
print(answer)
