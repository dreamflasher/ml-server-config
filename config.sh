#!/bin/sh

sudo add-apt-repository ppa:graphics-drivers/ppa -y
sudo add-apt-repository ppa:deadsnakes/ppa -y

sudo apt update -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt clean -y && sudo apt autoclean -y

sudo apt install unattended-upgrades zsh git-core keychain tmux mosh gcc gparted ubuntu-drivers-common python3.8 python3.8-dev python3-pip -y
sudo snap install micro --classic

sudo ubuntu-drivers autoinstall

sudo apt install nvidia-cuda-toolkit -y

printf "APT::Periodic::Update-Package-Lists "1";\nAPT::Periodic::Download-Upgradeable-Packages "1";\nAPT::Periodic::AutocleanInterval "7";\nAPT::Periodic::Unattended-Upgrade "7";\n" | sudo tee /etc/apt/apt.conf.d/20auto-upgrades

sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1

pip3 install joblib boost statsmodels wget pyhive psutil plotly natsort pandas tensorflow matplotlib scikit-learn jupyter nb_conda nb_conda_kernels notebook torch torchvision jupyter_contrib_nbextensions imtools wandb cachetools tensorboardX opencv-python pyarrow fastai

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -s --unattended

LINE='export PATH=/opt/conda/bin:$PATH'
grep -xqF -- "$LINE" ~/.bashrc || echo "$LINE" >> ~/.bashrc
grep -xqF -- "$LINE" ~/.zshrc || echo "$LINE" >> ~/.zshrc

LINE='if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then tmux attach-session -t s || tmux new-session -s s; fi'
grep -xqF -- "$LINE" ~/.bashrc || echo "$LINE" >> ~/.bashrc
grep -xqF -- "$LINE" ~/.zshrc || echo "$LINE" >> ~/.zshrc

LINE='DISABLE_UPDATE_PROMPT=true'
grep -xqF -- "$LINE" ~/.zshrc || echo "$LINE" >> ~/.zshrc

LINE='ZSH_THEME="gallois"'
grep -xqF -- "$LINE" ~/.zshrc || echo "$LINE" >> ~/.zshrc

cp .tmux.conf ~/
