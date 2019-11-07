#!/bin/sh

sudo add-apt-repository ppa:graphics-drivers/ppa

sudo apt update -y && sudo apt full-upgrade -y && sudo apt autoremove -y && sudo apt clean -y && sudo apt autoclean -y

sudo apt install unattended-upgrades zsh git-core keychain tmux mosh gcc gparted ubuntu-drivers-common -y
sudo snap install micro --classic

sudo ubuntu-drivers autoinstall

sudo apt install nvidia-cuda-toolkit

printf "APT::Periodic::Update-Package-Lists "1";\nAPT::Periodic::Download-Upgradeable-Packages "1";\nAPT::Periodic::AutocleanInterval "7";\nAPT::Periodic::Unattended-Upgrade "7";\n" | sudo tee /etc/apt/apt.conf.d/20auto-upgrades


curl https://repo.anaconda.com/pkgs/misc/gpgkeys/anaconda.asc | gpg --dearmor > conda.gpg && sudo install -o root -g root -m 644 conda.gpg /etc/apt/trusted.gpg.d/ 
echo "deb [arch=amd64] https://repo.anaconda.com/pkgs/misc/debrepo/conda stable main" | sudo tee /etc/apt/sources.list.d/conda.list

sudo apt update -y && sudo apt install conda 
sudo chmod -R a+rwx /opt/ && sudo chmod -R a+rwx /etc/apt/sources.list.d/

conda update conda -y && conda update --all -y
conda install joblib boost statsmodels wget pyhive psutil plotly natsort pandas tensorflow matplotlib scikit-learn jupyter nb_conda nb_conda_kernels notebook -y
conda install pytorch torchvision cudatoolkit=10.1 -c pytorch
pip install jupyter_contrib_nbextensions imtools wandb cachetools tensorboardX opencv-python pyarrow
conda install -c pytorch -c fastai fastai
