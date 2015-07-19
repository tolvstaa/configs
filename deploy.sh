#!/bin/bash

confidr=$(printf $0 | rev | cut -d" " -f1 | cut -d"/" -f2- | rev)
printf "\nWorking with directory '%s'\n" $confdir


# verify index file
indexfile=${confidr}/index

if [ ! -e $indexfile ]; then
	printf "Index file '${indexfile}' not found. Aborting.\n"
	exit 1
elif [ ! -r $indexfile ]; then
	printf "Index file '${indexfile}' could not be read. Aborting.\n"
	exit 1
fi

printf "Using index file '${indexfile}'...\n"

# get sections
sections=($(grep -e '^##' $indexfile | cut -c3-))


#print sections
printf "\nSections:\n"
printf "\t%s\n" ${sections[@]}

