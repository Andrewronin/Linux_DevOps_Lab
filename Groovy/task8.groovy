import groovy.json.JsonOutput
import groovy.json.JsonSlurper

def getSumDig(int n) {
    int sum = 0;
    while (n != 0) {
        sum = sum + (n % 10).toInteger();
        n = (n / 10).toInteger();
    }
    return sum
}
def parseAndFilterJson(text) {

    def result = [:]
    def jsonSlurper = new JsonSlurper()
    def object = jsonSlurper.parseText(text)
        object.each {key, value->
        if (getSumDig(value) == 9)
            result.put(key, value)
        }
    json = JsonOutput.toJson(result)
    return json
}
return this
