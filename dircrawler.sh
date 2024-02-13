#!/bin/bash

#Copyright © 2023 just1nn1t
#All rights reserved. This project is licensed under GitHub's default copyright laws,
#meaning that I retain all rights to my source code and no one may reproduce,
#distribute, or create derivative works from my work.
#This tool is meant for research and educational purposes only and any malicious usage of this tool is prohibited.

scandir() {
  baseurl="$1"
  wordlist="$2"

  #loop through dirs from wordlist
  while IFS= read -r directory; do
    url="$baseurl/$directory"
    response=$(curl -s -o /dev/null -w "%{http_code}" "$url")

    #check if the HTTP response code is 200 (OK)
    if [ "$response" -eq 200 ]; then
      echo -e "\e[32m[+] \e[32mDirectory \e[32mfound\e[0m: $url"
    else
      echo -e "\e[91m[+] \e[91mDirectory \e[91mnot \e[91mfound\e[0m: $url"
    fi
  done < "$wordlist"
}

main() {
  #checks the number of command-line arguments
  if [ "$#" -ne 2 ]; then
    echo
    echo "Usage: $0 <http://example.com> <wordlist>"
    echo
    exit 1
  fi

  baseurl="$1"
  wordlist="$2"

  #check if the wordlist exists
  if [ ! -f "$wordlist" ]; then
    echo "Wordlist not found: $wordlist"
    exit 1
  fi

  #check if 'curl' is available
  if ! command -v curl &> /dev/null; then
    echo "curl is required but not installed. Please install curl."
    exit 101
  fi

  scandir "$baseurl" "$wordlist"
}

cat << "EOF"

▓█████▄  ██▓ ██▀███   ▄████▄   ██▀███   ▄▄▄       █     █░ ██▓    ▓█████  ██▀███     
▒██▀ ██▌▓██▒▓██ ▒ ██▒▒██▀ ▀█  ▓██ ▒ ██▒▒████▄    ▓█░ █ ░█░▓██▒    ▓█   ▀ ▓██ ▒ ██▒   
░██   █▌▒██▒▓██ ░▄█ ▒▒▓█    ▄ ▓██ ░▄█ ▒▒██  ▀█▄  ▒█░ █ ░█ ▒██░    ▒███   ▓██ ░▄█ ▒   
░▓█▄   ▌░██░▒██▀▀█▄  ▒▓▓▄ ▄██▒▒██▀▀█▄  ░██▄▄▄▄██ ░█░ █ ░█ ▒██░    ▒▓█  ▄ ▒██▀▀█▄     
░▒████▓ ░██░░██▓ ▒██▒▒ ▓███▀ ░░██▓ ▒██▒ ▓█   ▓██▒░░██▒██▓ ░██████▒░▒████▒░██▓ ▒██▒   
 ▒▒▓  ▒ ░▓  ░ ▒▓ ░▒▓░░ ░▒ ▒  ░░ ▒▓ ░▒▓░ ▒▒   ▓▒█░░ ▓░▒ ▒  ░ ▒░▓  ░░░ ▒░ ░░ ▒▓ ░▒▓░   
 ░ ▒  ▒  ▒ ░  ░▒ ░ ▒░  ░  ▒     ░▒ ░ ▒░  ▒   ▒▒ ░  ▒ ░ ░  ░ ░ ▒  ░ ░ ░  ░  ░▒ ░ ▒░   
 ░ ░  ░  ▒ ░  ░░   ░ ░          ░░   ░   ░   ▒     ░   ░    ░ ░      ░     ░░   ░    
   ░     ░     ░     ░ ░         ░           ░  ░    ░        ░  ░   ░  ░   ░        
 ░                   ░                                        by 1nn1t

EOF

main "$@"
