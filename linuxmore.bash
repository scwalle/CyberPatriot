#!/bin/bash

# Adds a pause statement
pause(){
	read -p "Press enter key to continue" dummyVarIWillNeverUse
}

# first check for everything

# check for root
if [[ $EUID -ne 0 ]]
then
  echo Erro: This script needs root
  exit 1
fi

# check for user list files
if [ ! -s normalusers.txt ] || [ ! -s admins.txt ]; then
  echo "Either filea or fileb does not exist/is empty"
  exit 1
fi

authusers=$( cat normalusers.txt admins.txt | sort | uniq )
adminusers=$( cat admins.txt | sort | uniq )

: <<PLEASEDONTRUN
# Loop through all users with UID 1000 and above in /etc/passwd file
for user in $(awk -F: '$3>=1000{print $1}' /etc/passwd); do
    # Check if the user is in the 'admin' group
    if id -nG "$user" | grep -qw "admin"; then
        # Check if the user is not listed in the adminusers file
        if ! grep -qw "^${user}$" /path/to/adminusers; then
            # Prompt for confirmation before deleting the user
            read -p "Do you want to delete user '$user'? (yes/no): " choice
            if [ "$choice" = "yes" ]; then
                # Attempt to delete the user and their home directory
                if userdel -r "$user"; then
                    echo "User '$user' removed from admin group and deleted."
                else
                    echo "Error: Failed to delete user '$user'."
                fi
            else
                echo "User '$user' not deleted."
            fi
        else
            echo "User '$user' is listed in adminusers file. Skipped."
        fi
    fi
done
PLEASEDONTRUN

echo "Current users:"
echo "$(cut -d: -f1 /etc/passwd)"

pause
echo ""

# TODO: impliment user password changes
read -p "Do you want to change any user passwords? (check README) (y/enter to continue): " choice
if [ ! -z $choice ]; then
	select useri in "Exit-menu" "${allusers[@]}"; do
		if [ "$user" == "Exit-menu" ]; then
			break
		fi

		echo "changing $useri password"
  		sudo passwd $useri
	done

fi




# VVV weird comment syntax, not actually a comment but it works
: '
#apt-cache rdepends <package>

echo delete files with nonexistant owners
find / -nogroup -nouser -delete




case $choice in
  1) option1;;
  2) option2;;
  3) etc;;
  4) etc;;
  *) echo "Invalid option. try again"
  ;;
esac
'
