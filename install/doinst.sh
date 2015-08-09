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

patch_config() {
    DIR="$(dirname $1)"

    PATCH="$(basename $1)"

    OLD="$(basename $PATCH .patch)"
    ORIG="$OLD.orig"
    NEW="$OLD.new"

    (
        cd "$DIR"

        if [ -r $ORIG ]; then
            mv "$ORIG" "$OLD"
        fi
       
        patch --strip=1 --output="$NEW" < "$PATCH" &&
            rm "$PATCH"
    )
}

mv etc/skel/bashrc.new etc/skel/.bashrc.new
config etc/skel/.bashrc.new

chmod -x /etc/profile.d/coreutils-dircolors.sh
chmod -x /etc/profile.d/coreutils-dircolors.csh
config etc/profile.d/init_ls.sh.new

config etc/profile.d/init_aliases.sh.new
config etc/profile.d/init_prompt.sh.new
config etc/profile.d/init_env.sh.new

patch_config etc/inputrc.patch
