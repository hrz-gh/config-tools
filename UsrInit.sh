# Get
./OhMyZshInstall.sh

# Install
git config --global user.email "hrz_ms@outlook.com"
git config --global user.name "hrz"
cp ./vim/.vimrc $HOME
mkdir --p ~/.config/nvim
cp -r  ./vim/nvim/* ~/.config/nvim

cp -r ./sh/. $HOME

# cp --parents ./xfce4/* ~/.config/xfce4/xfconf/xfce-perchannel-xml
