# AptCh
# cp /etc/apt/sources.list sources.list.bak
# sudo sed -i 's/archive.ubuntu.com/mirrors.cqu.edu.cn/g' /etc/apt/sources.list


# Get
apt update
apt upgrade

# 编译环境
apt install -y clang
apt install -y gdb
apt install -y make
apt install -y cmake
apt install -y npm
apt install -y build-essential
apt install -y ninja-build
apt install -y repo


# 工具
apt install -y neovim
apt install -y zsh


apt install -y python3-pip
pip3 install numpy ipython sympy matplotlib ipykernel
