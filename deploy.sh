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

printf "Using index file '${HL}${indexfile}${RS}'\n\n"



# validate index syntax
if ! isCat $(head $indexfile -n1); then
	printf "Incorrect syntax at head of index '${ERR}${indexfile}${RS}'. Aborting.\n\n"
	exit 1;
fi

# validate index contents
cat=""
item=""
broken=false
while read line; do
	if [ "$(echo $line | awk '{print NF}')" -ne 0 ]; then
		if isCat $line; then
			# validate category
			cat=${line:2}
			if [ ! -d ${confdir}/$cat ]; then
				printf "Configuration mismatch: "
				printf "Directory '${ERR}${cat}${RS}' not in '${ERR}${confdir}${RS}'.\n"
				broken=true
			fi
		else
			# validate item
			item=$(echo $line | awk '{print $1}')
			if [ "$(echo $line | awk '{print NF}')" -eq 2 ]; then
				if [ ! -r ${confdir}/${cat}/$item ]; then
					printf "Configuration mismatch: "
					printf "File '${ERR}${item}${RS}' not in '${ERR}${confdir}/${cat}${RS}'.\n"
					broken=true
				fi
			else
				printf "Configuration syntax error: "
				printf "Incorrect parameters for '${ERR}${cat}/${item}${RS}'.\n"
				broken=true
			fi
		fi
	fi
done < $indexfile

if [ "$broken" = true ]; then
	printf "\nErrors detected in config file. Aborting.\n\n"
	exit 1
fi


# get categories
declare -a categories=($(grep -e '^##' $indexfile | cut -c3-))


#print categories
printf "Categories:\n"
printf "\t%s\n" ${categories[@]}


printf "\n"
