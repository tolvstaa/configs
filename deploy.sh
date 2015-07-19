#!/bin/bash

HL="\033[32m" # Highlight yellow
ERR="\033[31m" # Error red
RS="\033[0m"   # Reset

printf "\n###### Inityx's Configs ######\n\n"


confdir=$(printf $0 | rev | cut -d" " -f1 | cut -d"/" -f2- | rev)

if [ "$confdir" != "." ]; then
	printf "Working with directory '${HL}%s${RS}'\n" $confdir
fi


# verify index file
if [ "$confdir" = "." ]; then
	indexfile=index
else
	indexfile=${confdir}/index
fi

if [ ! -e $indexfile ]; then
	printf "Index file '${ERR}${indexfile}${RS}' not found. Aborting.\n"
	exit 1
elif [ ! -r $indexfile ]; then
	printf "Index file '${ERR}${indexfile}${RS}' could not be read. Aborting.\n"
	exit 1
fi

printf "Using index file '${HL}${indexfile}${RS}'\n"


# get categories
categories=($(grep -e '^##' $indexfile | cut -c3-))


#print categories
printf "\nCategories:\n"
printf "\t%s\n" ${categories[@]}


printf "\n"
