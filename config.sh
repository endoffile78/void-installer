MKSWAP=1
UEFI=1
MUSL=0

VOLUME="volume"

BOOT=""
ROOT="/dev/mapper/$VOLUME-root"
SWAP="/dev/mapper/$VOLUME-swap"
DATA="/dev/mapper/$VOLUME-data"

ROOTSIZE="100%FREE"
SWAPSIZE="4G"
DATASIZE="100%FREE"

INTERFACE="eno1"

HOSTNAME="localhost"
TIMEZONE="America/Chicago"
REPO="http://alpha.us.repo.voidlinux.org"
PACKAGES="base-devel xorg xfce4 xfce4-whiskermenu-plugin emacs-gtk3 git zsh tmux firefox alacritty mpd ncmpcpp gnupg2 libreoffice curl vpsm neovim connman connman-gtk"
PACKAGES+=" pulseaudio pinentry-gtk zip unzip font-iosevka feh python gnome-disk-utility greybird-themes font-symbola dunst"
KEYMAP="us"
REPOS="void-repo-multilib void-repo-multilib-nonfree void-repo-nonfree"
