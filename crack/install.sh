#!/bin/bash


function comm_inst {
	
	lic_dir=${HOME}/.config/sublime-text-3/Local
	
	echo -e "Coping the license file into propper directory\n"

	if [ -f ${HOME}/.config/sublime-text-3/Local/License.sublime_license ]; then
		echo -e "Skipped"
	else
		if [ ! -d $lic_dir ]; then mkdir -pvm 777 ${HOME}/.config/sublime-text-3/Local; fi

		if [ ! -f ${HOME}/.config/sublime-text-3/Local/License.sublime_license ]; then
			cp -Rvf $(pwd)/License.sublime_license ${HOME}/.config/sublime-text-3/Local
		fi
	fi
	
	sleep 4
	echo -e "\nInstalling the links to the software\n"
	update-alternatives --install /usr/bin/sublime3 sublime $instdir/sublime3 1
	sleep 4

	echo -e "\nCreating the desktop link\n"

	if [ ! -f ${HOME}/.local/share/applications/sublime.desktop ]; then
		touch ${HOME}/.local/share/applications/sublime.desktop
		echo -e "
[Desktop Entry]
Encoding=UTF-8
Version=1.0
Type=Application
Terminal=false
TryExec=/usr/bin/sublime
Name=Sublime 3
Icon=${instdir}/Icon/32x32/sublime-text.png
" >> ${HOME}/.local/share/applications
		sleep 4
	fi
}

function usr_inst {
	echo -e "Please enter the path of your Sublime directory: "
	read instdir
	echo -e "\n"
	echo -e "Copying the script: bas.sh to the sublime directory and makine it executable\n"
	cp -Rvf $(pwd)/bas.sh $instdir
	chmod -Rvf 777 $instdir
	sleep 3
	comm_inst
	sleep 3
}

function def_inst {
	echo "Preforming default (minimal) instalation: "
	echo
	echo -e "Runing the script with will prevent of blocking the license"
	$(pwd)/bas.sh
	sleep 3
	comm_inst
	sleep 3
}

if [ "$#" -eq 0 ]; then echo -e "
  USAGE: install.sh <install_type>, where the <install_type> is one of:

  * default
  * user
		
  USAGE EXAMPLES:

  ./install.sh default
  ./install.sh user
"
else
	case "$1" in
		default)
			def_inst
			;;
		user)
			usr_inst
			;;
	esac
fi
