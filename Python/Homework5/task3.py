def is_self_dividing(number):
    for digit in str(number):
        if digit == '0' or number % int(digit):
            return False
    return True


def rang(left, right):
    answer = []
    for each in range(left, right + 1):
        if is_self_dividing(each):
            answer.append(each)
    return answer


if __name__ == '__main__':
    print(rang(int(input("left = ")), int(input("right = "))))
