#!/bin/bash

function exit_error()
{
    ret_code=$?
    if [[ $ret_code -ne 0 ]]
    then
	echo Installation aborted
	exit $ret_code
    fi
}

function install_zsh()
{
    echo Installing zsh theme
    cp zsh/.p10k.zsh $HOME/.p10k.zsh
    exit_error
}

if [[ $@ == *"zsh"* ]]
then
    install_zsh
fi

echo Installed successfully
