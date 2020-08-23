pacstrap /mnt base \
    base-devel \
    linux \
    linux-firmware \
    zsh \
    man-pages \
    man-db \
    git \
    neovim \
    networkmanager \
    iwd

# xinit alternative
# pacstrap /mnt lightdm lightdm-gtk-greeter

# install video driver
# pacstrap /mnt xf86-video-intel xf86-video-nouveau

# for virtualbox
# pacstrap /mnt xf86-video-vmware
