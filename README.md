
#### Install VirtualBox
Go to www.virtualbox.com

Start a New VM, 64 GB VDI,  8GB RAM, Dynamic Allocation using the *amd64.iso file

Then on the VM, "Devices" -> "Insert Guest Additions CD" to  install the guest additions for Ubuntu

#### Updates to Ubuntu

    $ sudo apt-get install emacs24 emacs24-el emacs24-common-non-dfsg
    $ sudo apt-get install terminator
    $ sudo apt-get install emacs
    $ sudo apt-get install meld
    $ sudo apt-get install apt-file
    $ apt-file update
    $ sudo apt-get update
    $ sudo apt-get install libtiff4-dev
    $ sudo apt-get install libssl-dev
    $ sudo apt-get install openssl
    $ sudo apt-get install gnome-system-tools
    $ sudo apt-get install gnome-session-fallback # Will go back to the older version without compiz and uses Gnome. Very useful
    $ sudo apt-get install tree vim
    $ sudo apt-get install build-essentials
    $ sudo apt-get install openssh-server # for sshd daemon running
    $ sudo apt-get update
    $ sudo apt-get install libpcre3 libpcre3-dev
    $ sudo apt-get install libboost-all-dev
    $ sudo apt-get install aptitude
    $ aptitude search boost 

vi ~/.bashrc and add

    alias lt='ls -altr'
    alias la='ls -A'
    alias l='ls -CF'
    alias ll='ls -alF'
    alias c=clear
    alias h=history
    alias rm='rm -i'
    alias clt='clear; ls -alt'

#### Git setup

    sudo apt-get install git gitk git-gui
    git config --global user.name "Arvind Agrawal"
    git config --global user.email "arvindag@gmail.com"
    git config --global core.editor vi

vi ~/.gitconfig # to see the git config entries

# ssh key generation

    cd ~
    mkdir .ssh
    cd .ssh/
    ssh-keygen -t dsa -C "arvindag@gmail.com"
    mv id_dsa id_dsa.personalpn
    mv id_dsa.pub id_dsa.personalpn.pub

Upload the dsa.personalpn.pub on the github.com "Settings" and "ssh keys" section

vi config
Add "

    Host github.com
        HostName github.com
        Port 22
        IdentityFile ~/.ssh/id_dsa.personalpn
"

    ssh -T git@github.com

Please make sure that the 'ssh-add -l' command lists the id_dsa.personalpn file else
run 'ssh-all ~/.ssh/id_dsa.personalpn' to include it

Clone github files to local area

    mkdir ~/PeerNova
    cd PeerNova
    git clone git@github.com:peernova/Peer-Audit.git
    git clone git@github.com:peernova/Eldorado.git
    git clone git.peernova.com/Cuneiform/cuneiform.git

cd ~/personal

    git clone git@github.com:arvindag/Misc-Docs.git

To get a particular branch:

    mkdir <newdir>
    cd <newdir>
    git clone -b <branchname> git@github.com:peernova/Peer-Audit.git

#### Emacs Setting
~/.emacs file settings

    (custom-set-variables
    ;; custom-set-variables was added by Custom.
    ;; If you edit it by hand, you could mess it up, so be careful.
    ;; Your init file should contain only one such instance.
    ;; If there is more than one, they won't work right.
    '(column-number-mode t))
    (custom-set-faces
    ;; custom-set-faces was added by Custom.
    ;; If you edit it by hand, you could mess it up, so be careful.
    ;; Your init file should contain only one such instance.
    ;; If there is more than one, they won't work right.
    )
    (global-set-key   [f2]     'set-mark-command)            ; F2
    (global-set-key   [f3]     'copy-to-register)            ; F3
    (global-set-key   [f4]     'insert-register)             ; F4
    (global-set-key   [f5]     'call-last-kbd-macro)         ; F5
    (global-set-key   [f6]     'other-window)                ; F6
    (global-set-key   [f7]     'delete-other-windows)        ; F7
    (global-set-key   [f8]     'split-window-vertically)     ; F8
    (global-set-key   [f9]     'split-window-horizontally)   ; F9
    (global-set-key   [f10]    'list-buffers)                ; F10
    ;; For Ubuntu
    (global-set-key   [f11] `goto-line)                   ; F11
    (global-set-key   [f12] `save-buffer)                 ; F12
    (global-set-key   [kp-begin]    'kill-buffer)                 ; 5 (Numeric Pad)
    (global-set-key   "\C-r"   'query-replace)               ; C-r
    (global-set-key   "\C-u"   'undo)                        ; C-u
    (global-set-key   [delete] 'delete-char)                 ; DEL
    (global-set-key   "\e\e"   'eval-expression)             ; ESC-ESC
    (global-set-key   "\C-z"   'bury-buffer)                 ; C-z
    (global-set-key   "\C-x\C-b" 'buffer-menu-other-window)  ; C-x C-b


#### More ubuntu installs

    sudo apt-get install pypy
    sudo apt-get install -y python-pip python-virtualenv
    sudo apt-get install idle
    sudo apt-get install valgrind
    sudo apt-get install dkms
    sudo apt-get install ntp # for date and time sync

For NodeJS:

    sudo apt-get install nodejs
    sudo apt-get install npm
    sudo ln -s /usr/bin/nodejs /usr/sbin/node
    npm install ws
    npm install twit


To download coinbase data (not needed now)

    wget https://gist.githubusercontent.com/drewx2/17841067e5fb154a98da/raw/3d1d323d2ba9f12e5a900906b207708083079089/coinbase-websocket
    mv coinbase-websocket coinbase.js
    mkdir coinbase
    mv coinbase.js coinbase
    cd coinbase/
    node coinbase.js 

#### Bitcoin and Picocoin download:

    git clone https://github.com/bitcoin/bitcoin.git
    git clone https://github.com/picocoin/picocoin.git
    
#### For Mac OSX:

    Install OSXFUSE and SSHFS from https://osxfuse.github.io/
    Install Xcode from Apple AppStore
    Install Iterm2 (from www.iterm2.com)
    Sublime (http://www.sublimetext.com/2)
    Get better .bashrc, .profile and git-prompt.sh files from other users
    install macports (https://guide.macports.org/chunked/installing.macports.html)
    sudo port install tree
    sudo port install emacs
    sudo easy_install pip
    sudo pip install pandas

#### Installing Valgrind on mac OSX:

    svn co svn://svn.valgrind.org/valgrind/trunk valgrind
    cd valgrind
    ./autogen.sh
    ./configure
    make
    make install
