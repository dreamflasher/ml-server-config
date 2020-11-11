wget -O ~/vsls-reqs https://aka.ms/vsls-linux-prereq-script && chmod +x ~/vsls-reqs && sudo ~/vsls-reqs

wget -O azcopy.tar https://aka.ms/downloadazcopy-v10-linux && tar -xvf azcopy.tar && sudo cp -f ./azcopy_linux_amd64_*/azcopy /usr/bin/ && sudo chmod +777 /usr/bin/azcopy

sudo mkdir /data && sudo chmod +777 /data

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

shutdownscript="[Unit]
Description=Auto-Shutdown

[Service]
Type=simple
PIDFile=/run/auto-shutdown.pid
ExecStart=/usr/local/bin/python3 /home/$USER/azure-auto-shutdown.py
User=$USER
Group=$USER
WorkingDirectory=/
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target"

echo "$shutdownscript" | sudo tee /etc/systemd/system/auto-shutdown.service
cp azure-auto-shutdown.py ~/
nano ~/azure-auto-shutdown.py
sudo systemctl daemon-reload && sudo systemctl enable auto-shutdown && sudo systemctl start auto-shutdown

az login --use-device-code
