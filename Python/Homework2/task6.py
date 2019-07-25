def translate(code, base):
    z = []
    for i in range(len(code)):
        for j in range(len(base)):
            if code[i] == base[j]:
                z.append(j)
    return z


def translate2(code, base):
    z = []
    for i in range(len(code)):
        for j in range(len(base)):
            if code[i] == j:
                z.append(base[j])
    return z


string = input()
upper = '0123456789ABCDEFGHIJKLMNOPQ'
lower = '  abcdefghigklmnopqrstuvwxyz '
l1 = []

length = len(string)
integer_division = length // 27
remainder = length % 27


for i in range(integer_division):
    l1.extend(translate(string[i * 27:i * 27 + 26], upper))

l1.extend(translate(string[length - remainder:length], upper))

for i in range(len(l1)):
    x = l1[i] - i + 27 * (i // 27)
    if x <= 0:
        x += 27
    l1[i] = x

l1 = translate2(l1, lower)
for i in l1:
    print(i, end="")
