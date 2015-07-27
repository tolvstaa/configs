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
[ "$confdir" != "." ] && printf "Working with directory '${HL}${confdir}${RS}'\n";

# define index file
[ "$confdir" = "." ] && indexfile=$confname || indexfile=${confdir}/$confname

# validate index file
[ ! -e $indexfile ] && # file dne
	( printf "Index file '${ERR}${indexfile}${RS}' not found. Aborting.\n\n"; exit 1)
	
( [ ! -r $indexfile ] || [ ! -s $indexfile ] ) && # file unreadable
	( printf "Index file '${ERR}${indexfile}${RS}' could not be read. Aborting.\n\n"; exit 1)

printf "Using index file '${HL}${indexfile}${RS}'\n\n"



# validate index syntax
isCat $(head $indexfile -n1) ||
	( printf "Incorrect syntax at head of index '${ERR}${indexfile}${RS}'. Aborting.\n\n"; exit 1 )

# validate index contents
cat=""
item=""
broken=false
while read line; do
	[ "$(echo $line | awk '{print NF}')" -ne 0 ] && (
		isCat $line && (
			# validate category
			cat=${line:2}
			[ -d ${confdir}/$cat ] || (
				printf "Configuration mismatch: "
				printf "Directory '${ERR}${cat}${RS}' not in '${ERR}${confdir}${RS}'.\n"
				broken=true
			)
		) || (
			# validate item
			item=$(echo $line | awk '{print $1}')
			[ "$(echo $line | awk '{print NF}')" -eq 2 ] && (
				[ -r ${confdir}/${cat}/$item ] || (
					printf "Configuration mismatch: "
					printf "File '${ERR}${item}${RS}' not in '${ERR}${confdir}/${cat}${RS}'.\n"
					broken=true
				)
			) || (
				printf "Configuration syntax error: "
				printf "Incorrect parameters for '${ERR}${cat}/${item}${RS}'.\n"
				broken=true
			)
		)
	)
done < $indexfile

[ "$broken" = true ] && ( printf "\nErrors detected in config file. Aborting.\n\n"; exit 1 )


# get categories
declare -a categories=($(grep -e '^##' $indexfile | cut -c3-))


#print categories
printf "Categories:\n"
printf "\t%s\n" ${categories[@]}


printf "\n"
