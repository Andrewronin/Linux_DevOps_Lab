import ipaddress

m1 = []
m2 = []
n1 = int(input())
for i in range(n1):
    m1.append(ipaddress.ip_address(str(input())))
print(m1)
n2 = int(input())
for i in range(n2):
    m2.append(ipaddress.ip_address(str(input())))
print(m2)