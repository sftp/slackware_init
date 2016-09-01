config() {
    NEW="$1"
    OLD="$(dirname $NEW)/$(basename $NEW .new)"
    # If there's no config file by that name, mv it over:
    if [ ! -r $OLD ]; then
        mv $NEW $OLD
    elif [ "$(cat $OLD | md5sum)" = "$(cat $NEW | md5sum)" ]; then # toss the redundant copy
        rm $NEW
    fi
    # Otherwise, we leave the .new copy for the admin to consider...
}

mv etc/skel/bashrc.new etc/skel/.bashrc.new
config etc/skel/.bashrc.new

mv etc/skel/emacs.new etc/skel/.emacs.new
config etc/skel/.emacs.new

chmod -x /etc/profile.d/coreutils-dircolors.sh
chmod -x /etc/profile.d/coreutils-dircolors.csh
config etc/profile.d/init_ls.sh.new

config etc/profile.d/init_aliases.sh.new
config etc/profile.d/init_prompt.sh.new
config etc/profile.d/init_env.sh.new

config etc/login.defs.new
config etc/inputrc.new
