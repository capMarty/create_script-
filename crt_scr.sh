#! /bin/bash

PATH_DIR="$HOME/bin";

if [[ $# == 0 ]]; then
	echo "$(basename $0 .sh) Usage -[i|n name]";
	exit 1;
fi	

function check_name {
	echo -n "input name of command> "; 
	read name_com;
	   	if [[ !("$name_com" =~ ^[A-Za-z0-9]+\.sh$) ]]; then 
			echo "invalid file name";
			check_name;
		fi;

		if [[ -f $PATH_DIR/$name_com ]]; then
			echo "file is exist";
			check_name;
		fi;
}

function check_mod {
	echo -n "input mod for file[for example: 777]> "; 
	read mod;
		if [[ !("$mod" =~ ^[0-7]{3,4}$) ]]; then
			echo "incorrect mod";
			check_mod;
		fi;
}

function add_script {
	mod=${2:-"+x"};
	cd $PATH_DIR;	
	touch $1;
	chmod $mod $1; 
	echo "#! /bin/bash" > $1;
	vim $1;
}

while getopts "in:" opt; do
	case $opt in
		n) if [[ "$OPTARG" =~ ^[A-Za-z0-9]+\.sh$ ]]; then
			if [[ -f $PATH_DIR/$OPTARG ]]; then
				echo "file is exist";
				exit 1;
			fi;
		   	add_script $OPTARG;
		   else echo "invalid file name"; 	
		   fi ;;

	   	i) check_name; 
		   check_mod;
   		   add_script $name_com $mod;	

        esac
done	
