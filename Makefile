#################################################################################################
# GIT STUFF
#################################################################################################
git-subm-init:
	git submodule update --init --remote --merge --recursive
	git clone https://github.com/zsh-users/zsh-syntax-highlighting ${HOME}/.repos/other/ohmyzsh/plugins/zsh-syntax-highlighting
	git clone https://github.com/marlonrichert/zsh-autocomplete.git ${HOME}/.repos/other/ohmyzsh/plugins/zsh-autocomplete
	git clone https://github.com/zsh-users/zsh-autosuggestions.git  ${HOME}/.repos/other/ohmyzsh/plugins/zsh-autosuggestions

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
	cd ${HOME}/.gits/other/neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo && sudo make install

install-yays:
	yay --sync --needed --norebuild --noredownload --nocleanmenu --nodiffmenu --noremovemake - < $(PKGS)/yays

install-pacmans:
	sudo pacman -S --noconfirm --needed - < ${PKGS}/pacmans 

install-pythons:
	pip install -r ${PKGS}/pythons

backup-pkgs:
	pacman -Qnq > ${PKGS}/pacmans
	pacman -Qqem > ${PKGS}/yays
	pip freeze > ${PKGS}/pythons
	git commit .pkgs/* -m "updated packages"

#################################################################################################
# PACKAGE STUFF
#################################################################################################

#################################################################################################
# SYSTEM STUFF
#################################################################################################

setup-tlp:
	sudo cp ${HOME}/.config/system/tlp.conf /etc/

backup-tlp:
	sudo cp /etc/tlp.conf ${HOME}/.config/system/

setup-sysd-slock:
	sudo cp ${HOME}/.config/system/slock-hibernate@.service ${HOME}/.config/system/slock-suspend@.service /etc/systemd/system/
	sudo systemctl enable slock-suspend@$USER
	sudo systemctl enable slock-hibernate@$USER

#################################################################################################
# SYSTEM STUFF
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
