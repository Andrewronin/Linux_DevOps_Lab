import os
import sys
import platform
import datetime
from flask import Flask

app = Flask(__name__)
for line in os.popen("pip freeze").read().split("\n"):
    if not line.find("Flask"):
        version = line[7:]

time = os.getenv("TIME")
day = datetime.datetime.strptime(time, "%Y-%m-%d_%H:%M:%S")
print(day)
family = os.getenv("FAMILY")
parameter = os.getenv("PARAMETER")

@app.route("/")
def start():
    now_time = datetime.datetime.now() + datetime.timedelta(hours=3)
    UTC_time = datetime.datetime.now()
    delta = now_time - day
    page = '<html><body><h1>'
    page += "Python version = " + sys.version.split("/n")[0].split()[0] + "<br />"
    page += "Flask version = " + version + "<br />"
    page += "OS Name = " + platform.system() + "<br />"
    page += "Release Version = " + platform.version() + "<br />"
    page += "Family Name = " + family + "<br />"
    page += "Kernel version = " + platform.release() + "<br />"
    page += "Build time = " + day.strftime('%H:%M:%S / %d.%m.%Y') + "<br />"
    page += "Minsk time = " + now_time.strftime('%H:%M:%S / %d.%m.%Y' ) + "<br />"
    page += "UTC time = " + UTC_time.strftime('%H:%M:%S / %d.%m.%Y') + "<br />"
    page += "Hostname = " + os.popen("hostname").read() + "<br />"
    page += "IP = " + os.popen("hostname -i").read()+ "<br />"
    page += "Student Name = " + "Andrey Pavarnitsyn" + "<br />"
    page += "Custom env = " + parameter + "<br />"
    page += "Container life time = " + str(delta.seconds) + " seconds <br />"
    page += '</h1></body></html>'
    return page

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=os.getenv('PORT')) # port 5000 is the default
