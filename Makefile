#################################################################################################
# GIT STUFF
#################################################################################################
git-subm-init:
	git submodule update --init --remote --merge --recursive

git-subm-update-local:
	git submodule update --recursive

#################################################################################################
# GIT STUFF
#################################################################################################

#################################################################################################
# PACKAGE STUFF
#################################################################################################
install-yay:
	cd ${HOME}/.gits/other/yay/ && makepkg -si

install-neovim:
	cd ${HOME}/.repos/other/neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install clean

install-yays:
	yay --sync --needed --norebuild --noredownload --nocleanmenu --nodiffmenu --noremovemake - < $(HOME)/.pkgs/yays

install-pacmans:
	sudo pacman -S --noconfirm --needed - < ${HOME}/.pkgs/pacmans 

install-pythons:
	pip install -r ${HOME}/.pkgs/pythons

backup-pkgs:
	pacman -Qnq > ${HOME}/.pkgs/pacmans
	pacman -Qqem > ${HOME}/.pkgs/yays
	pip freeze > ${HOME}/.pkgs/pythons
	git commit .pkgs/* -m "updated packages"

#################################################################################################
# PACKAGE STUFF
#################################################################################################

#################################################################################################
# SYSTEM STUFF
#################################################################################################
setup-tlp:
	sudo mv /etc/tlp.conf /etc/tlp.conf.backpup
	sudo ln -sf /home/julius/.repos/personal/other/system-configs/tlp.conf /etc/tlp.conf

setup-sysd-slock:
	sudo cp ${HOME}/.config/system/slock-hibernate@.service ${HOME}/.config/system/slock-suspend@.service /etc/systemd/system/
	sudo systemctl enable slock-suspend@$USER
	sudo systemctl enable slock-hibernate@$USER

#################################################################################################
# SYSTEM STUFF
#################################################################################################

#################################################################################################
# ZSH STUFF
#################################################################################################
setup-zsh:
	ln -sf ${HOME}/.config/zsh/.zshrc ${HOME}/.zshrc
	sh ${HOME}/.local/bin/install-zsh-plugins

#################################################################################################
# ZSH STUFF
#################################################################################################

#################################################################################################
# SUCKLESS STUFF
#################################################################################################
setup-dwm:
	cd ${HOME}/.repos/personal/suckless/dwm && sudo make install clean

setup-dmenu:
	cd ${HOME}/.repos/personal/suckless/dmenu && sudo make install clean

setup-dwmblocks:
	cd ${HOME}/.repos/personal/suckless/dwmblocks && sudo make install clean

setup-slock:
	cd ${HOME}/.repos/personal/suckless/slock && sudo make install clean

setup-st:
	cd ${HOME}/.repos/personal/suckless/st && sudo make install clean

setup-sxiv:
	cd ${HOME}/.repos/personal/suckless/sxiv && sudo make install clean

setup-xmenu:
	cd ${HOME}/.repos/personal/suckless/xmenu && sudo make install clean

setup-suckless: setup-dwm setup-dwmblocks setup-st setup-dmenu setup-slock setup-sxiv setup-xmenu
#################################################################################################
# SUCKLESS STUFF
#################################################################################################
	
backup: backup-pkgs backup-tlp

#################################################################################################
# BOOTSTRAP
#################################################################################################
bootstrap: git-subm-init install-pacmans install-pythons install-neovim install-yay install-yays giter-get-repos setup-tlp setup-suckless
