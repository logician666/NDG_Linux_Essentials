#! /bin/bash                                                                    

# For each department, create a user group, and for that group create an        
# administrator user account and two normal user accounts. Also, create a       
# corresponding directory under the root directory.                             
groups=(engineers salesmen sysAnalysts)                                         

declare -A users depts                                                          
users=( [engineers]="seniorEng eng1 eng2"                                       
[salesmen]="seniorSO salesman1 salesman2"                               
[sysAnalysts]="seniorSA sysAnalyst1 sysAnalyst2"                        
)                                                                               
depts=( [${groups[0]}]=engineering                                              
[${groups[1]}]=sales                                                    
[${groups[2]}]=infoSystems                                              
)                                                                               

for group in ${groups[@]}; do                                                   
	groupadd $group                                                         

	# Create users, each with a home directory, bash as his login shell,    
	# and $group as it's primary group!                                     
	for user in ${users[$group]}; do                                        
               useradd -m -s /bin/bash -g $group $user                         
        done                                                                    
                                                                                
        # For each department create a directory under the root directory with  
        # permission: rwxrwsrwt                                                 
        dir=/${depts[$group]}                                                   
        mkdir -m 3770 $dir                                                      
        admin=$(echo ${users[$group]} | cut -d' ' -f1)                          
        chown $admin:$group $dir                                                
                                                                                
        readme=$dir/README                                                      
        echo "This file contains confidential information for the department." > $readme                                                                        
        chown $admin:$group $readme                                             
        chmod 770 $readme                                                       
done                                                                            
                                                                                
# Leave a time window as directory special permissions may take some time to be
# in effect
sleep 5                                                                         
                                                                                
# Verify and then clean:                                                                       
for group in ${groups[@]}; do                                                   
        grep $group /etc/group                                                  
                                                                                
        for user in ${users[$group]}; do                                        
                echo                                                            
                grep $user /etc/passwd                                          
                id $user                                                        
                userdel -r $user                                                
        done                                                                    
                                                                                
        dir=/${depts[$group]}                                                   
        echo                                                                    
        ls -dl $dir                                                             
        ls -l $_/README                                                         
        groupdel $group                                                         
        rm -rf $dir                                                             
done                                                                            
