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
