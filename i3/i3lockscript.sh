#!/bin/bash
#if [ $(echo $USER) = "andy" ] || [ $(echo $USER) = "tolvstaa" ]

if which mogrify &> /dev/null
then
	scrot /tmp/i3lockscrot.png
	mogrify -spread 10 -blur 0x8 -level -5% /tmp/i3lockscrot.png
	i3lock -i /tmp/i3lockscrot.png
	rm -f /tmp/i3lockscrot.png
else
	i3lock -c 666666
fi
