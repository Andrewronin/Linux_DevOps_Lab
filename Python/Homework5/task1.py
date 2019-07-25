import subprocess
import os
import yaml
import json

data = {}
with open('output.json', 'w') as file:
    json.dump(data, file)
with open('output.yaml', 'w') as file:
    yaml.dump(data, file)

versions = subprocess.run(["pyenv", "versions"], capture_output=True).stdout
full_list_of_versions = list(str(versions)[2:-3].split("\\n"))
short_list_of_versions = set()
for each in full_list_of_versions:
    each = each[2:].split("/")[0].split()[0]
    short_list_of_versions.add(each)

for each in short_list_of_versions:
    scr = "./script.sh " + str(each)
    data = os.popen(scr).read()
    data2 = json.loads(data.replace("'", "\""))
    print(data2)
    with open('output.json', 'a') as file:
        json.dump(data2, file, indent=4)

    with open('output.yaml', 'a') as file:
        yaml.dump(data2, file)
