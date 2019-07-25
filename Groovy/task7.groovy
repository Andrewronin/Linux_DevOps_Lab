def encryptThis(text) {
    words = text.split()
    result = []
    words.each { word ->
        if (word.size() == 1) {
            new_word = ((int) word).toString()
        } else {
            new_word = word.split('')
            new_word[0] = ((int) new_word[0]).toString()
            temp = new_word[1]
            new_word[1] = new_word[-1]
            new_word[-1] = temp
        }
        result.add(new_word.join(''))
    }

    return result.join(' ')
}
return this