#!/bin/sh

# Make sure this is before the 'exec' command or it won't be sourced.
[ -f /etc/xprofile ] && source /etc/xprofile
[ -f ~/.xprofile ] && source ~/.xprofile

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

export DESKTOP_SESSION=gnome
export XDG_CURRENT_DESKTOP=GNOME
export QT_QPA_PLATFORMTHEME="qt5ct"

export XKB_DEFAULT_OPTIONS=caps:swapescape

#exec compton -cb
#exec fcitx
#exec sudo nm-applet
#exec blueman-applet
#exec copyq
#exec udiskie
#exec xautolock

exec i3

xset r rate 200 30
setxkbmap -option caps:swapescape

