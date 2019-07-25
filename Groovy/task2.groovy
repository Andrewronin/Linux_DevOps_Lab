def mulEvenOdd(data) {
    def result = []

    data.each {
        def Even = it % 2
        if (Even == 0) {
            result.add(it * 2)
        }
        else {
            result.add(it * 3)
        }
    }
    return result
}

return this