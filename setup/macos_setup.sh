#!/bin/bash
mkdir -p ~/local

which -s brew
if [[ $? != 0 ]] ; then
	echo 'Installing homebrew...'
    mkdir -p ~/local/homebrew 
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
	echo 'Updating homebrew...'
    brew update
fi

echo 'Checking python version'
if [[ $(python --version 2>&1) =~ 2\.7 ]]
    then
        echo 'Python 2.7 found. Continuing...'
    else
    	echo 'Installing Python 2.7...'
        wget http://www.python.org/ftp/python/2.7.14/Python-2.7.14.tgz
		tar xvzf Python-2.7.14.tgz
		cd Python-2.7.3
		./configure
		make
		make altinstall prefix=~/local  # specify local installation directory
		ln -s ~/local/bin/python2.7 ~/local/bin/python
fi

echo 'Installing pygobject3...'
brew install pygobject3 --with-python3 gtk+3
echo 'Installing wget...'
brew install wget
echo 'Installing pip...'
brew install pip


#Pip Dependencies
echo 'Installing pip dependencies...'
pip install psutil
pip install requests
pip install tzlocal
