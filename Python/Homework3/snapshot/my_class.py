#!/usr/bin/env python

import psutil
import time
from prettytable import PrettyTable
import json
import os


class Snapshot:

    count = 0

    def __init__(self):
        self.cpu = psutil.cpu_percent(interval=1)
        self.load = psutil.getloadavg()
        self.mem = psutil.disk_usage('/').percent
        self.vmem = psutil.virtual_memory().percent
        self.io = psutil.disk_io_counters(perdisk=False)
        self.net = psutil.net_io_counters(pernic=False)
        Snapshot.count += 1

    def make(self):
        self.cpu = psutil.cpu_percent(interval=1)
        self.load = psutil.getloadavg()
        self.mem = psutil.disk_usage('/').percent
        self.vmem = psutil.virtual_memory().percent
        self.io = psutil.disk_io_counters(perdisk=False)
        self.net = psutil.net_io_counters(pernic=False)
        Snapshot.count += 1

    def output(self, path, tipe):
        output_path = str(os.path.join(path, 'output/output.') + tipe)
        if not os.path.exists(os.path.join(path, 'output')):
            os.mkdir(os.path.join(path, 'output'))

        if tipe == "txt":
            header = PrettyTable(["Number", "Time", "CPU load"])
            header.add_row([Snapshot.count, time.ctime(), self.load])

            table1 = PrettyTable(["CPU", "MEMORY", "VIRTUAL"])
            table1.add_row([self.cpu, self.mem, self.vmem])

            table2 = PrettyTable(["Read count", "Write count", "Busy time"])
            table2.add_row([self.io.read_bytes,
                            self.io.write_bytes,
                            self.io.busy_time])

            table3 = PrettyTable(["Bytes/sent", "/Received", "Errors/in", "/out"])
            table3.add_row([self.net.bytes_sent,
                            self.net.bytes_recv,
                            self.net.errin,
                            self.net.errout])

            with open(output_path, 'a+') as file:
                file.write("\n{:^58}\n".format("TIMESTAMP"))
                file.write(str(header))
                file.write("\n{:^27}\n".format("MAIN INFORMATION"))
                file.write(str(table1))
                file.write("\n{:^42}\n".format("I/O INFORMATION"))
                file.write(str(table2))
                file.write("\n{:^46}\n".format("NETWORK"))
                file.write(str(table3))
                file.write("\n")

        else:
            data = json.dumps({
                "SNAPSHOT": Snapshot.count,
                "TIMESTAMP": time.ctime(),
                "CPU": self.cpu,
                "CPU load": self.load,
                "MEMORY": self.mem,
                "VIRTUAL": self.vmem,
                "Read count": self.io.read_bytes,
                "Write count": self.io.write_bytes,
                "Busy time": self.io.busy_time,
                "Bytes/sent": self.net.bytes_sent,
                "/Received": self.net.bytes_recv,
                "Errors/in": self.net.errin,
                "/out": self.net.errout
            }, indent=4)

            with open(output_path, 'a+') as file:
                file.write(data)
