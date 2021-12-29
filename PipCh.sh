mkdir ~/.pip/
touch ~/.pip/pip.conf
echo "[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple" > ~/.pip/pip.conf
echo 'source ~/.myshrc
source ~/.myzshrc' >> $HOME/.zshrc
echo 'source $HOME/.myprofile' >> $HOME/.profile
