#!/bin/bash
#if [ $(echo $USER) = "andy" ] || [ $(echo $USER) = "tolvstaa" ]

which mogrify
installed="$?"
which mogrify
installed=(($installed + $?))

if [ "$installed" -eq "0" ]
then
	scrot /tmp/i3lockscrot.png
	mogrify -spread 10 -blur 0x8 -level -30% /tmp/i3lockscrot.png
	i3lock -i /tmp/i3lockscrot.png
else
	i3lock -c 666666
fi
