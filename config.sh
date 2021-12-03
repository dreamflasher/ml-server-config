#!/bin/sh

# add opendns DNS (else the ppa's sometimes can't be resolved)
sudo apt update -y
sudo apt install resolvconf -y
echo "nameserver 208.67.222.222" | sudo tee /etc/resolvconf/resolv.conf.d/base > /dev/null

sudo add-apt-repository ppa:graphics-drivers/ppa -y
sudo add-apt-repository ppa:deadsnakes/ppa -y

sudo apt update -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt clean -y && sudo apt autoclean -y

sudo apt install unattended-upgrades snapd zsh git-core keychain mosh gcc gparted ubuntu-drivers-common python3.9 python3.9-dev python3.9-distutils python3-distutils ncdu x11-apps xclip xsel build-essential devscripts debhelper fakeroot locate -y
sudo updatedb
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3.9 get-pip.py
sudo snap install micro --classic
sudo apt remove tmux -y
sudo snap install tmux-non-dead --classic
sudo snap alias tmux-non-dead.tmux tmux

sudo ubuntu-drivers autoinstall

sudo apt-key adv --fetch-keys  http://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub
sudo bash -c 'echo "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64 /" > /etc/apt/sources.list.d/cuda.list'
sudo bash -c 'echo "deb http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu2004/x86_64 /" > /etc/apt/sources.list.d/cuda_learn.list'

sudo apt update -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt clean -y && sudo apt autoclean -y
sudo apt install cuda-11-3 libcudnn8 libnccl2 -y

printf "APT::Periodic::Update-Package-Lists "1";\nAPT::Periodic::Download-Upgradeable-Packages "1";\nAPT::Periodic::AutocleanInterval "7";\nAPT::Periodic::Unattended-Upgrade "7";\n" | sudo tee /etc/apt/apt.conf.d/20auto-upgrades

sudo update-alternatives --install /usr/local/bin/python3 python3 /usr/bin/python3.9 1
sudo chmod -R a+rw /usr/local/bin/
sudo chmod -R a+rw /usr/local/lib/
sudo chmod -R a+rw /usr/local/share/
sudo chmod -R a+rw /usr/local/etc/
sudo chmod -R a+rw /usr/local/include/
sudo chmod -R a+rw /usr/lib/python3/

export PATH=~/.local/bin:/usr/local/cuda/bin:$PATH
python3 -m pip install joblib boost statsmodels wget pyhive psutil isort plotly natsort pandas matplotlib scikit-learn jupyter notebook jupyter_contrib_nbextensions imtools wandb cachetools tensorboard tensorboardX opencv-python pyarrow fastai mypy flake8 pydocstyle pycodestyle autopep8 autoflake black yapf
python3 -m pip install torch===1.10.0+cu113 torchvision===0.11.1+cu113 torchaudio===0.10.0+cu113 -f https://download.pytorch.org/whl/torch_stable.html

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" -s --unattended
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

LINE='export PATH=~/.local/bin:/snap/bin:$PATH'
grep -xqF -- "$LINE" ~/.bashrc || echo "$LINE" >> ~/.bashrc
grep -xqF -- "$LINE" ~/.zshrc || echo "$LINE" >> ~/.zshrc

LINE='export OMP_NUM_THREADS=24'
grep -xqF -- "$LINE" ~/.bashrc || echo "$LINE" >> ~/.bashrc
grep -xqF -- "$LINE" ~/.zshrc || echo "$LINE" >> ~/.zshrc

LINE='if [[ -z "$TMUX" ]] && [ "$SSH_CONNECTION" != "" ]; then tmux attach-session -t s || tmux new-session -s s; fi'
grep -xqF -- "$LINE" ~/.bashrc || echo "$LINE" >> ~/.bashrc
grep -xqF -- "$LINE" ~/.zshrc || echo "$LINE" >> ~/.zshrc

LINE='DISABLE_UPDATE_PROMPT="true"'
grep -xqF -- "$LINE" ~/.zshrc || sed  -i "1i $LINE" ~/.zshrc

LINE='plugins=(git zsh-autosuggestions)'
grep -xqF -- "$LINE" ~/.zshrc || sed  -i "1i $LINE" ~/.zshrc

sed -i 's/ZSH_THEME=.*/ZSH_THEME="gallois"/' ~/.zshrc

cp .tmux.conf ~/
cp .ssh/* ~/.ssh/
mkdir ~/.tmux/tmux-resurrect/

tmux
~/.tmux/plugins/tpm/scripts/install_plugins.sh
~/.tmux/plugins/tpm/bin/install_plugins
