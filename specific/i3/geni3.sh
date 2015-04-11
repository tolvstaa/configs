#!/bin/bash

if [ "$HOSTNAME" == "localhost" ]; then
	echo set \$mod Mod1 # $mod = Alt
else
	echo set \$mod Mod4 # $mod = Meta
fi

# Font for window titles. Will also be used by the bar unless a different font
# is used in the bar {} block below.
# This font is widely installed, provides lots of unicode glyphs, right-to-left
# text rendering and scalability on retina/hidpi displays (thanks to pango).
# font pango:DejaVu Sans Mono 8
echo font pango:Arial Regular 9
# Before i3 v4.8, we used to recommend this one as the default:
# font -misc-fixed-medium-r-normal--13-120-75-75-C-70-iso10646-1
# The font above is very space-efficient, that is, it looks good, sharp and
# clear in small sizes. However, its unicode glyph coverage is limited, the old
# X core fonts rendering does not support right-to-left and this being a bitmap
# font, it doesn’t scale on retina/hidpi displays.

# Use Mouse+$mod to drag floating windows to their wanted position
echo floating_modifier \$mod

# start a terminal
echo bindsym \$mod+Return exec gnome-terminal

# kill focused window
echo bindsym \$mod+c kill

# start dmenu (a program launcher)
echo bindsym \$mod+r exec dmenu_run
# There also is the (new) i3-dmenu-desktop which only displays applications
# shipping a .desktop file. It is a wrapper around dmenu, so you need that
# installed.
# bindsym $mod+d exec --no-startup-id i3-dmenu-desktop

# alternatively, you can use the cursor keys:
echo "
bindsym \$mod+Left focus left
bindsym \$mod+Down focus down
bindsym \$mod+Up focus up
bindsym \$mod+Right focus right"

# alternatively, you can use the cursor keys:
echo "
bindsym \$mod+Shift+Left move left
bindsym \$mod+Shift+Down move down
bindsym \$mod+Shift+Up move up
bindsym \$mod+Shift+Right move right"

# split in horizontal orientation
echo bindsym \$mod+h split h

# split in vertical orientation
echo bindsym \$mod+v split v

# enter fullscreen mode for the focused container
echo bindsym \$mod+f fullscreen

# change container layout (stacked, tabbed, toggle split)
echo "
bindsym \$mod+s layout stacking
bindsym \$mod+w layout tabbed
bindsym \$mod+e layout toggle split"

# toggle tiling / floating
echo bindsym \$mod+Control+space floating toggle

# change focus between tiling / floating windows
echo bindsym \$mod+space focus mode_toggle

# focus the parent container
echo bindsym \$mod+a focus parent

# focus the child container
#bindsym $mod+d focus child

echo new_window 1pixel

# switch to workspace
echo "
bindsym \$mod+1 workspace 1
bindsym \$mod+2 workspace 2
bindsym \$mod+3 workspace 3
bindsym \$mod+4 workspace 4
bindsym \$mod+5 workspace 5
bindsym \$mod+6 workspace 6
bindsym \$mod+7 workspace 7
bindsym \$mod+8 workspace 8
bindsym \$mod+9 workspace 9
bindsym \$mod+0 workspace 10
bindsym \$mod+F1 workspace 11
bindsym \$mod+F2 workspace 12
bindsym \$mod+F3 workspace 13
bindsym \$mod+F4 workspace 14
bindsym \$mod+F5 workspace 15
bindsym \$mod+F6 workspace 16
bindsym \$mod+F7 workspace 17
bindsym \$mod+F8 workspace 18
bindsym \$mod+F9 workspace 19
bindsym \$mod+F10 workspace 20"

# move focused container to workspace
echo "
bindsym \$mod+Shift+1 move container to workspace 1
bindsym \$mod+Shift+2 move container to workspace 2
bindsym \$mod+Shift+3 move container to workspace 3
bindsym \$mod+Shift+4 move container to workspace 4
bindsym \$mod+Shift+5 move container to workspace 5
bindsym \$mod+Shift+6 move container to workspace 6
bindsym \$mod+Shift+7 move container to workspace 7
bindsym \$mod+Shift+8 move container to workspace 8
bindsym \$mod+Shift+9 move container to workspace 9
bindsym \$mod+Shift+0 move container to workspace 10
bindsym \$mod+Shift+F1 move container to workspace 11
bindsym \$mod+Shift+F2 move container to workspace 12
bindsym \$mod+Shift+F3 move container to workspace 13
bindsym \$mod+Shift+F4 move container to workspace 14
bindsym \$mod+Shift+F5 move container to workspace 15
bindsym \$mod+Shift+F6 move container to workspace 16
bindsym \$mod+Shift+F7 move container to workspace 17
bindsym \$mod+Shift+F8 move container to workspace 18
bindsym \$mod+Shift+F9 move container to workspace 19
bindsym \$mod+Shift+F10 move container to workspace 20"

# move current workspace to display
echo "
bindsym \$mod+Shift+Control+Right move workspace to output right
bindsym \$mod+Shift+Control+Left move workspace to output left"


# reload the configuration file
echo bindsym \$mod+Shift+c reload
# restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
echo bindsym \$mod+Shift+r restart
# exit i3 (logs you out of your X session)
echo bindsym \$mod+Shift+e exec \"i3-nagbar -t warning -m \'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.\' -b \'Yes, exit i3\' \'i3-msg exit\'\"

# resize window (you can also use the mouse for that)
echo "
mode \"resize\" {
        # These bindings trigger as soon as you enter the resize mode

        # Pressing left will shrink the window’s width.
        # Pressing right will grow the window’s width.
        # Pressing up will shrink the window’s height.
        # Pressing down will grow the window’s height.
        bindsym j resize shrink width 10 px or 10 ppt
        bindsym k resize grow height 10 px or 10 ppt
        bindsym l resize shrink height 10 px or 10 ppt
        bindsym semicolon resize grow width 10 px or 10 ppt

        # same bindings, but for the arrow keys
        bindsym Left resize shrink width 10 px or 10 ppt
        bindsym Down resize grow height 10 px or 10 ppt
        bindsym Up resize shrink height 10 px or 10 ppt
        bindsym Right resize grow width 10 px or 10 ppt

        # back to normal: Enter or Escape
        bindsym Return mode \"default\"
        bindsym Escape mode \"default\"
}"

echo bindsym \$mod+d mode \"resize\"

# Startup programs
echo "
exec nm-applet
exec dropboxd"

# Program shortcuts
echo "
#bindsym \$mod+l exec xscreensaver-command -lock
bindsym \$mod+l exec ~/.i3/i3lockscript.sh
bindsym \$mod+b exec google-chrome-stable"

# Start i3bar to display a workspace bar (plus the system information i3status
# finds out, if available)
echo "
bar {
        status_command	i3status
		position		top
		font			pango:Arial Regular 9
}
"
