all: bootstrap

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
	cd ${HOME}/.repos/other/yay/ && makepkg -si

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
	sudo ln -sf /home/julius/.repos/personal/other/system-configs/xorg-slock-setting.conf /etc/X11/xorg.conf.d/xorg-slock-setting.conf
	sudo ln -sf /home/julius/.repos/personal/other/system-configs/slock-hibernate@.service /etc/systemd/system/slock-hibernate@.service
	sudo systemctl enable slock-hibernate@${USER}
	sudo ln -sf /home/julius/.repos/personal/other/system-configs/slock-suspend@.service /etc/systemd/system/slock-suspend@.service
	sudo systemctl enable slock-suspend@${USER}

setup-hibernation:
	chmod +x ${HOME}/.repos/other/hibernator/hibernator
	sudo ${HOME}/.repos/other/hibernator/hibernator 8G # for 8G Swap
	sudo ln -sf /home/julius/.repos/personal/other/system-configs/99-lowbat.rules /etc/udev/rules.d/99-lowbat.rules
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

#################################################################################################
# OTHER STUFF
#################################################################################################
setup-autorotate:
	cd ${HOME}/.repos/personal/tools/autoRotate && sudo make install clean

setup-directories:
	mkdir -p ${HOME}/.stuff/share
	mkdir -p ${HOME}/.stuff/trash
	mkdir -p ${HOME}/.stuff/mount
	mkdir -p ${HOME}/.stuff/screenshots
	mkdir -p ${HOME}/.stuff/important


add-backgrounds:
	git add ${HOME}/.stuff/backgrounds
	git commit ${HOME}/.stuff/backgrounds -m "added backgrounds"
#################################################################################################
# OTHER STUFF
#################################################################################################

#################################################################################################
# BOOTSTRAP
#################################################################################################
bootstrap: git-subm-init install-pacmans install-pythons install-neovim install-yay install-yays setup-zsh setup-hibernation setup-suckless setup-tlp setup-sysd-slock
