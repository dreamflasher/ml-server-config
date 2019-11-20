import time
import os
import psutil
from collections import deque

d = deque(maxlen=120*60)  # only look at the last 120 minutes
while True:
    cpu = psutil.cpu_percent()
    d.append(cpu)
    if len(d) >= 120*60:  # wait at least 120 min after reboot
        if max(d) < 9:  # max smaller than 9 percent auto shutdown
            os.system('az vm deallocate -g "$GROUP" -n "$VMNAME"')
						os.system('az vmss deallocate -g "$GROUP" -n "$VMNAME"')
    time.sleep(1)
