wget -O ~/vsls-reqs https://aka.ms/vsls-linux-prereq-script && chmod +x ~/vsls-reqs && sudo ~/vsls-reqs

wget -O ~/azcopy.tar https://aka.ms/downloadazcopy-v10-linux && tar -xvf azcopy.tar && sudo cp -f ./azcopy_linux_amd64_*/azcopy /usr/bin/

curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
az login
