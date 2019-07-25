def exec (command) {
    def com
    com = command.execute()
    return com.text.trim()
}
return this