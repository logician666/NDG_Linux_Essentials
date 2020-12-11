#! /bin/bash

# Note:
# The requirments provided by the lab objectives dictates that if the
# group name supplied to the script already exists, an error should
# be raise.  But, we find this inconveniet. As with the later introduced
# behaviour, the script can be used to create users and set the supplied
# group argument it's primary group.  So we modify this to the following
# behavious: If the group name supplied to the script doesn't exist,
# a new one is created. Else, the user name is checked for existence,
# if it does an error is raised. Otherwise, a new user account is created
# with the supplied user name with the group as it's primary group.

# Pseudocode:
# if group doesn't exist:
#    create group
# else:
#    if username exits:
#        raise Error
#    else
#        create user account

# create home directory for user `username' with: BASE=/ SHELL=/bin/bash
# set group as primary group for username
# set a default password for the user

if [ $# -ne 2 ]; then
	echo "Usage: $0 username group"
       exit 1
fi       

getent passwd $1 &>/dev/null                                                    
if [ $? -ne 0 ]; then                                                           
        getent group $2 &>/dev/null                                             
        if [ $? -ne 0 ]; then                                                   
                groupadd $2                                                     
        fi                                                                      
        useradd -m -b / -s /bin/bash -g $2 -p defaultpass $1                    
        chmod 1770 /$1             
else
	echo "$0: Error: User $1 already exists!"
	exit 1
fi

# Verify:
id     $1
getent group $2 
ls -l /$1

# # Clean up:
userdel	-r $1
groupdel   $2
