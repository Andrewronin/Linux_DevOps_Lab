def gstring(text, int index){
    def line
        if (index == 1) {line = "1(${text}) 2() 3()"}
        if (index == 2) (line = "1() 2(${text}) 3()")
        if (index == 3) {line = "1() 2() 3(${text})"}
    return line
    }
return this