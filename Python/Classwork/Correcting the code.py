count = 0
sum = 0
CountTo = 20

while count <= CountTo:
    num = int(input('Enter next number: '))
    count += 1
    sum += count
    if count == CountTo:
        break

print("Sum:",sum)
