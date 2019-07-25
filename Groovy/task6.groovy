def adults(map) {
    def result = [:]
    map.each { key, value ->
        if (value > 17) {
        result.put(key, value)
       }
    }
    return result
}
return this
