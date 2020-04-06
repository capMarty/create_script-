#! /bin/bash +x

PATH_DIR="$HOME/bin";

function check_name {
	echo -n "input name of command> "; 
	read name_com;
	   	if [[ !("$name_com" =~ ^[A-Za-z0-9]+\.sh$) ]]; then 
			echo "incorrect name's file";
			check_name;
		fi;

		if [[ -f $name_com ]]; then
			echo "file is exist";
			check_name;
		fi;
}

function check_mod {
	echo -n "input mod for file[for example: 777]> "; 
	read mod;
		if [[ !("$mod" =~ ^[0-7]{3,4}$) ]]; then
			echo "incorrect mode";
			check_mod;
		fi;
}

function add_file {
	mod=${2:-"+x"};
	cd $PATH_DIR;	
	touch $1;
	chmod +x $1; 
	echo "#! /bin/bash" > $1;
	vim $1;
}

while getopts "in:" opt; do
	case $opt in
		n) if [[ "$OPTARG" =~ ^[A-Za-z0-9]+\.sh$ ]]; then
			if [[ -f $OPTARG ]]; then
				echo "file is exist";
				exit 1;
			fi;
		   	add_file $OPTARG;
		   else echo "incorrect name's file"; 	
		   fi ;;

	   	i) check_name; 
		   check_mod;
   		   add_file $name_com $mod;	

        esac
done	
