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
    return 0
}

function config(){
    # Config rc
    for i in "${ORIGIN_CONFIG_PATH[@]}"
    do
        echo "${i}"
        if [ -e ${i} ]; then
            echo "${i} is already config."
        else
            config_path="${UPLOAD_CONFIG_PATH}/${i##*/}"
            if [ -d ${config_path} ]; then
                mkdir -p ${i} 
                cp -r ${config_path}/* ${i}
                check "cp -r ${config_path} ${i}"
            else
                cp ${config_path} ${i}
                check "cp ${config_path} ${i}"
            fi
        fi
    done

    # Get oh-my-zsh
    if [ -d "~/.oh-my-zsh" ]; then
        echo "Oh-my-zsh is already config."
    else
        ./src/install.sh
        check "Exec oh-my-zsh sh"
    fi
}

function download() {
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

    sudo ./src/download.sh
    git config --global user.email "hrz_ms@outlook.com"
    git config --global user.name "hrz"
    git config --global credential.helper store    
}


function usage() {
    echo -e "Usage option:\n\tinit\n\tupload\n\tsync"

}

KERNEL_NAME=$(uname)

if [ "$#" -gt "1" ] || [ "$#" -eq "0" ]; then
    usage
    exit 1
fi

case ${1} in
    "init")
        download
        config
        echo "source ~/.shrc" >> ~/.zshrc
        check "Add shrc"
        ;;
    "upload")
        upload
        ;;
    "sync")
        if [ ${KERNEL_NAME} = "Linux" ]; then
            config
        elif [ ${KERNEL_NAME} = "Darwin" ]; then
            config
        else
            echo "${KERNEL_NAME} is not support"
            exit 1
        fi
        ;;
    *)
        usage
        exit 1
        ;;
esac
