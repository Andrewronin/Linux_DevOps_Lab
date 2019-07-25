alphabet = 'qwertyuiopasdfghjklzxcvbnmq'
symbol = input('Symbol = ')

for i in range(len(alphabet) - 1):
    if alphabet[i] == symbol:
        print(alphabet[i + 1])
