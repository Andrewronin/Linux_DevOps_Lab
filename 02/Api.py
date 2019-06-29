import requests
import json
import subprocess
from requests.auth import HTTPBasicAuth


def post(request):
    headers = {'content-type': 'application/json'}
    url = "http://" + zabbix_server + "/zabbix/api_jsonrpc.php"
    return requests.post(
        url,
        data=json.dumps(request),
        headers=headers,
        auth=HTTPBasicAuth(zabbix_api_admin_name, zabbix_api_admin_password)
    )


def are_in_one_net(ip1, ip2, mask="255.255.255.0"):
    count = 0
    for i in range(4):
        int1 = int(ip1.split(".")[i]) & int(mask.split(".")[i])
        int2 = int(ip2.split(".")[i]) & int(mask.split(".")[i])
        if int1 == int2:
            count += 1
    if count == 4:
        return True
    else:
        return False


def register_host(host, ip, token):
    post({
        "jsonrpc": "2.0",
        "method": "host.create",
        "params": {
            "host": host,
            "templates": [{"templateid": "10001"}],
            "interfaces": [{"type": 1,
                            "main": 1,
                            "useip": 1,
                            "ip": ip,
                            "dns": "",
                            "port": "10050"}],
            "groups": [{"groupid": 15}]
        },
        "auth": token,
        "id": 1
    })


zabbix_server = "192.168.133.101"
zabbix_api_admin_name = "API"
zabbix_api_admin_password = "password"
list_of_ip = str(subprocess.check_output(['hostname', '--all-ip-addresses']))[2:-3].split()
hostname = str(subprocess.check_output(['hostname']))[2:-3]
Usefull_ip = [ip for ip in list_of_ip if are_in_one_net(ip, zabbix_server)][0]
auth_token = post({"jsonrpc": "2.0",
                   "method": "user.login",
                   "params": {"user": zabbix_api_admin_name, "password": zabbix_api_admin_password},
                   "auth": None,
                   "id": "0"
                   }).json()["result"]
register_host(hostname, Usefull_ip, auth_token)
