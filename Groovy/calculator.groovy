def exec(text) {
    while (text.find(/[0-9]\(/)) {
        def tmp, find
        find=text.find(/[0-9]\(/)
        tmp=find.replace("(","*(")
        text=text.replace(find, tmp)
    }
    while (text.find(/\)\(/)) {
        def tmp, find
        find=text.find(/\)\(/)
        tmp=find.replace("(","*(")
        text=text.replace(find, tmp)
    }

    def result
    result = rawcalc(unbrasket(text)).trim().toInteger()
    return result
}

def unbrasket(expression) {
    //println("unbracket start = $expression")

    def it, find, tmp, check, internal, temp
    while (expression.find(/\((.*?)\)/)) {
        find = expression.find(/\((.*?)\)/)
        check = find.replaceFirst(/\(/, "")
        if (check.find(/\((.*?)\)/)) {
            internal = check.find(/\((.*?)\)/)
            tmp = unbrasket(internal)
            temp = expression.replace(internal, tmp)
            expression = temp
        }
        else {
            it = check.replaceFirst(/\)/, " ")
            expression = expression.replace(find, rawcalc(it).toString()).trim()
        }
    }
    //println("unbracket return = $expression")
    return expression
}

def rawcalc(text) {
    //println("rawcalc start = $text")
    def find
            while (text.find(/(\d+)\s*([*\/])\s*(\d+)/)) {
        find = text.find(/(\d+)\s*([*\/])\s*(\d+)/)
        text = text.replace(find, calculate(find).toString())
    }
    while (text.find(/(\d+)\s*([+-])\s*(\d+)/)) {
        find = text.find(/(\d+)\s*([+-])\s*(\d+)/)
        text = text.replace(find, calculate(find).toString())
    }
    //println("rawcalc start = $text")
    return text
}


def calculate(expression) {
    if (expression.find(/(\d+)\s*([*\/+-])\s*(\d+)/)) {
        def temp, left, right, operator
        temp = expression =~ /(\d+)\s*([*\/+-])\s*(\d+)/
//        println(temp[0][1])
//        println(temp[0][2])
//        println(temp[0][3])
        left=temp[0][1].toInteger()
        operator=temp[0][2]
        right=temp[0][3].toInteger()
//        println("temp = ${temp}")
//        println("left = ${left}")
//        println("oper = ${operator}")
//        println("right = ${right}")

        switch(operator) {
            case '-': return (left - right); break
            case '+': return (left + right); break
            case '*': return (left * right); break
            case '/': return (left.intdiv(right)); break
            }
}
}
//println(exec('23*8'))
//println(exec('3+(2+3(4+3)*(2+3))'))
//println(exec("(8*5+5)*5+(1+(5+9)+9/3)*(1+0)"))
//println(exec("(8*5+5)*5+(1+(5+9)+9/3)*(1+5+5/1)"))
//println(exec("(((1+2)))"))

return this
