
import os
import sys

data = {}
answer = str()

each = str(sys.argv[1:])[2:-2]

path = sys.prefix
bin_path = path + "/bin"
# 1 version

data["Python version = "] = ".".join(map(str, sys.version_info[:3]))

# 2 Environment name
data["Environment name = "] = each

# 3 executable

data["Exec path = "] = sys.executable

# 4 pip location
data["pip location = "] = os.popen('which pip').read()[:-1]

# 5 PYTHONPATH
data["PYTHONPATH = "] = sys.path

# 6 Install packages
if not os.path.exists(sys.path[-1]):
    data["Install packages = "] = "No packages"
else:
    answer = os.popen('pip freeze').read()
    if answer:
        answer = str(answer).replace("\n", ",").replace("==", " : ")[:-1]
        data["Installed packages = "] = answer.split(",")
    else:
        data["Installed packages = "] = "No packages"

# 7 Site packages
data["site-packages = "] = sys.path[-1]
print(data)
