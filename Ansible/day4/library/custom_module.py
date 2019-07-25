#!/usr/bin/python
from ansible.module_utils.basic import *
import requests
import psutil
import re

DOCUMENTATION = '''
---
module: custom_module_args_python
version_from: 18.07.2019
short_description: Simple Ansible Module written on Python
description:
- This is an example module which returns some information about your host
author:
- "Andrey Pavarnitsyn"
'''

def main():
    module = AnsibleModule(
        argument_spec = dict(
            process         = dict(required=False, type='str'),
            port            = dict(required=False, type='int'),
            content_url     = dict(required=False, type='str'),
            content_regexp  = dict(required=False, type='str'),
            header_url      = dict(required=False, type='str'),
            header_regexp   = dict(required=False, type='str')
        ),
        supports_check_mode = True
    )
    results = {}

    if module.params["process"]:
        answer1 = {module.params["process"]: "NOT FOUND"}
        for proc in psutil.process_iter():
            try:
                if proc.name() == module.params["process"]:
                    answer1 = {"PID": proc.pid, "name": proc.name(), "User": proc.username()}
            except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
                pass
        results.update({"process": str(answer1)})

    if module.params["port"]:
        answer2 = {module.params["port"]: "NOT FOUND"}
        for proc in psutil.process_iter():
            try:
                if proc.connections() != []:
                    for item in proc.connections():
                        port = item[3][1]
                        status = item[5]
                        if status == "LISTEN":
                            if port == module.params["port"]:
                                 answer2 = {"PID": proc.pid, "name": proc.name(), "User": proc.username()}
            except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
                pass
        results.update({"port": str(answer2)})

    if module.params["content_url"] and module.params["content_regexp"]:
        content = requests.get(module.params["content_url"]).text
        grep1 = re.search(module.params["content_regexp"], content)
        if grep1:
            answer3 = {"URL_Match": module.params["content_regexp"], "Result": "was found"}
        else:
            answer3 = {"URL_Match": module.params["content_regexp"], "Result": "NOT FOUND"}
        results.update({"web_content": str(answer3)})

    if module.params["header_url"] and module.params["header_regexp"]:
        header = requests.get(module.params["header_url"]).headers
        grep2 = re.search(module.params["header_regexp"], str(header))
        if grep2:
            answer4 = {"Header_Match": module.params["header_regexp"], "Result": "was found"}
        else:
            answer4 = {"URL_Match": module.params["header_regexp"], "Result": "NOT FOUND"}
        results.update({"web_server": str(answer4)})

    module.exit_json(changed=False, results=results)

if __name__ == '__main__':
    main()
