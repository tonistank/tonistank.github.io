#!/usr/bin/bash

## 设置git本地配置

function setGitConfig()
{
	#echo -n "E-Mail for 'http://192.168.0.146': "
	#read email
	#echo -n "Username for 'http://192.168.0.146': "
	#read username
	#echo -n "Password for 'http://192.168.0.146': "
	#read password
	read -p "E-Mail for 'http://192.168.0.146': " email
	read -p "Username for 'http://192.168.0.146': " username
	read -p "Password for 'http://192.168.0.146': " password
	if [ ! -z $email ]
	then
		git config --global user.email "$email"
	fi
	if [ ! -z $username ]
	then
		git config --global user.name "$username"
	fi
	if [ ! -z $password ]
	then
		git config --global user.signingKey "$password"
	fi
	echo "[*] Please re-execute this bash script."
}

## 判断git配置文件是否存在

function checkGitConfig()
{
	if [ -f ~/.gitconfig ]
	then
		if [[ ! `cat ~/.gitconfig | grep "[user]"` =~ "[user]" ]]
		then
			echo "[-] Your user-config dosen't configured."
			setGitConfig
			exit
		elif [[ ! `cat ~/.gitconfig | grep email` =~ "email" ]]
		then
			echo "[-] Your email dosen't configured."
			setGitConfig
			exit
		elif [[ ! `cat ~/.gitconfig | grep name` =~ "name" ]]
		then
			echo "[-] Your name dosen't configured."
			setGitConfig
			exit
		elif [[ ! `cat ~/.gitconfig | grep signingKey` =~ "signingKey" ]]
		then
			echo "[-] Your signingKey dosen't configured."
			setGitConfig
			exit
		fi
	else
		echo "[-] Your \".gitconfig\" dosen't exsited."
		setGitConfig
		exit
	fi
}

## 参数判断

function checkArgs()
{
	if [ -n $1 ]
	then
		echo 1
	fi
}

if [ ! -d ./.git/ ]
then
	echo "[-] fatal: not a git repository (or any of the parent directories): .git"
	exit
else
	if [ ! -f .gitignore ]
	then
		echo $0 >> .gitignore
	fi
	checkGitConfig
	checkArgs
fi
#echo ${1}