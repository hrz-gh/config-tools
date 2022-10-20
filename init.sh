#!/bin/bash

UPLOAD_CONFIG_PATH=./config
ORIGIN_CONFIG_PATH=(~/.vimrc ~/.shrc ~/.config/nvim) 

function check(){
    if [ $? -eq 0 ]; then
        echo "${1} is successful."
    else
        echo "${1} is fail."
        exit 1
    fi
    return 0
}

function upload(){
    if [ -d $UPLOAD_CONFIG_PATH ]; then
        rm -rf $UPLOAD_CONFIG_PATH 
    fi
    mkdir $UPLOAD_CONFIG_PATH

    check "mk UPLOAD_CONFIG_PATH"
    if [ $? -eq 0 ]; then
        for i in "${ORIGIN_CONFIG_PATH[@]}"
        do
            if [ -d ${i} ]; then
                cp -r ${i} $UPLOAD_CONFIG_PATH
                check "cp -r ${i} $UPLOAD_CONFIG_PATH"
            elif [ -e ${i} ]; then
                cp ${i} $UPLOAD_CONFIG_PATH
                check "cp ${i} $UPLOAD_CONFIG_PATH"
            fi
        done
    else
        return 1
    fi
    return 0
}

function config(){

    # Config Pip
    if [ -e "~/.pip/pip.conf" ]; then
        echo "Pip source is alreay config."
    else
        if [ ! -d "~/.pip" ]; then
            mkdir ~/.pip
        fi
        echo -e "[global]\nindex-url = https://pypi.tuna.tsinghua.edu.cn/simple" > ~/.pip/pip.conf
        check "Config pip source"
    fi

    # Get oh-my-zsh
    if [ -d "~/.oh-my-zsh" ]; then
        echo "Oh-my-zsh is already config."
    else
        ./src/install.sh
        check "Exec oh-my-zsh sh"
    fi


    # Config rc
    for i in "${ORIGIN_CONFIG_PATH[@]}"
    do
        if [ -e ${i} || -d ${i} ]; then
            echo "${i} is already config."
        else
            config_path="${UPLOAD_CONFIG_PATH}/${i:${#HOME}+1:${#i}}"
            cp ${config_path} ${i}
            check "cp ${config_path} ${i}"
        fi
    done
    echo "source ~/.shrc" >> ~/.zshrc
    check "Add shrc"
}

function download() {
    sudo ./src/download.sh
    git config --global user.email "hrz_ms@outlook.com"
    git config --global user.name "hrz"
}

if [ "$#" -gt "1" ] || [ "$#" -eq "0" ]; then
    echo "args vaild"
    exit 1
fi

case ${1} in
    "--upload")
        upload
        ;;
    "--download")
        download
        ;;
    "--config")
        config
        ;;
    *)
        echo -e "Usage:\n\t--upload\n\t--download\n\t--config"
        exit 1
esac
