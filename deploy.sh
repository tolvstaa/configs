#!/bin/bash

HL="\033[32m" # Highlight yellow
ERR="\033[31m" # Error red
RS="\033[0m"   # Reset
confname=index
isCat() {
	[ "$(echo $1 | cut -c-2)" = "##" ] || return 1 # Failure
	return 0 # Success
}


printf "\n###### Inityx's Configs ######\n\n"


# define configurations directory
confdir=$(printf $0 | rev | cut -d" " -f1 | cut -d"/" -f2- | rev)

if [ "$confdir" != "." ]; then printf "Working with directory '${HL}${confdir}${RS}'\n"; fi

# define index file
if [ "$confdir" = "." ]; then indexfile=$confname
else indexfile=${confdir}/$confname; fi

# validate index file
if [ ! -e $indexfile ]; then
	# file dne
	printf "Index file '${ERR}${indexfile}${RS}' not found. Aborting.\n\n"
	exit 1
elif [ ! -r $indexfile ] || [ ! -s $indexfile ]; then
	# file unreadable
	printf "Index file '${ERR}${indexfile}${RS}' could not be read. Aborting.\n\n"
	exit 1
fi

printf "Using index file '${HL}${indexfile}${RS}'\n"



# validate index syntax
if ! isCat $(head $indexfile -n1); then
	printf "Incorrect syntax in index '${ERR}${indexfile}${RS}'. Aborting.\n\n"
	exit 1;
fi

# validate index contents
cat=""
item=""
while read line; do
	if [ "$(echo $line | awk '{print NF}')" -ne 0 ]; then
		if isCat $line; then
			# validate category
			cat=${line:2}
			if [ ! -d ${confdir}/$cat ]; then
				printf "Configuration mismatch found:\n"
				printf "\tDirectory '${ERR}${cat}${RS}' not in '${ERR}${confdir}${RS}'. Aborting.\n\n"
				exit 1
			fi
		else
			# validate item
			item=
			if [ ! -r ${confdir}/${cat}/$item ]; then
				printf "Configuration mismatch found:\n"
				printf "\tFile '${ERR}${item}${RS}' not in '${ERR}${confdir}/${cat}${RS}'. Aborting.\n\n"
			fi
		fi
	fi
done < $indexfile




# get categories
declare -a categories=($(grep -e '^##' $indexfile | cut -c3-))


#print categories
printf "\nCategories:\n"
printf "\t%s\n" ${categories[@]}


printf "\n"
