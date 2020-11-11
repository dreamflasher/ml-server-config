#!/bin/sh

# add opendns DNS (else the ppa's sometimes can't be resolved)
sudo apt update -y
sudo apt install resolvconf -y
echo "nameserver 208.67.222.222" | sudo tee /etc/resolvconf/resolv.conf.d/base > /dev/null

sudo add-apt-repository ppa:graphics-drivers/ppa -y
sudo add-apt-repository ppa:deadsnakes/ppa -y

sudo apt update -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt clean -y && sudo apt autoclean -y

sudo apt install unattended-upgrades zsh git-core keychain tmux mosh gcc gparted ubuntu-drivers-common python3.8 python3.8-dev python3.8-distutils python3-pip ncdu x11-apps xclip xsel build-essential devscripts debhelper fakeroot -y
sudo snap install micro --classic

sudo ubuntu-drivers autoinstall

sudo apt install nvidia-cuda-toolkit -y

printf "APT::Periodic::Update-Package-Lists "1";\nAPT::Periodic::Download-Upgradeable-Packages "1";\nAPT::Periodic::AutocleanInterval "7";\nAPT::Periodic::Unattended-Upgrade "7";\n" | sudo tee /etc/apt/apt.conf.d/20auto-upgrades

sudo update-alternatives --install /usr/local/bin/python3 python3 /usr/bin/python3.8 1

sudo python3 -m pip install --upgrade pip
python3 -m pip install joblib boost statsmodels wget pyhive psutil isort plotly natsort pandas matplotlib scikit-learn jupyter notebook torch torchvision jupyter_contrib_nbextensions imtools wandb cachetools tensorboardX opencv-python pyarrow fastai mypy flake8 pydocstyle pycodestyle autopep8 autoflake

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -s --unattended

LINE='export PATH=~/.local/bin:$PATH'
grep -xqF -- "$LINE" ~/.bashrc || echo "$LINE" >> ~/.bashrc
grep -xqF -- "$LINE" ~/.zshrc || echo "$LINE" >> ~/.zshrc

LINE='if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then tmux attach-session -t s || tmux new-session -s s; fi'
grep -xqF -- "$LINE" ~/.bashrc || echo "$LINE" >> ~/.bashrc
grep -xqF -- "$LINE" ~/.zshrc || echo "$LINE" >> ~/.zshrc

LINE='DISABLE_UPDATE_PROMPT="true"'
grep -xqF -- "$LINE" ~/.zshrc || sed  -i "1i $LINE" ~/.zshrc

sed -i 's/ZSH_THEME=.*/ZSH_THEME="gallois"/' ~/.zshrc

cp .tmux.conf ~/
cp .ssh/* ~/.ssh/

tmux
~/.tmux/plugins/tpm/scripts/install_plugins.sh
~/.tmux/plugins/tpm/bin/install_plugins
