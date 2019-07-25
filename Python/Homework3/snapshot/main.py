#!/usr/bin/env python

from snapshot.my_class import Snapshot
import json
import time
import os


def main():
    # Reading config

    ospath = os.path.abspath(os.path.dirname(__file__))
    config_path = os.path.join(ospath, 'config.json')

    with open(config_path, "r") as file:
        config = json.load(file)

    snap = Snapshot()

    # Endless while
    while True:
        snap.make()
        snap.output(ospath, config.get("output"))
        print("Snapshot was created")
        time.sleep(int(config.get("interval")))


if __name__ == "__main__":
    main()
