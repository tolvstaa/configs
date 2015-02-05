#!/bin/bash
if [ $(echo $USER) = "andy" ]
then
	scrot /tmp/i3lockscrot.png
	mogrify -blur 0x8 /tmp/i3lockscrot.png
	i3lock -i /tmp/i3lockscrot.png
else
	i3lock -c 666666
fi
