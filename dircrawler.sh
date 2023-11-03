#!/bin/bash

scandir() {
  baseurl="$1"
  wordlist="$2"

  #loop through dirs from wordlist
  while IFS= read -r directory; do
    url="$baseurl/$directory"
    response=$(curl -s -o /dev/null -w "%{http_code}" "$url")

    #check if the HTTP response code is 200 (OK)
    if [ "$response" -eq 200 ]; then
      echo "Directory found: $url"
    fi
  done < "$wordlist"
}

main() {
  if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <base_url> <wordlist_file>"
    exit 1
  fi

  baseurl="$1"
  wordlist="$2"

  #check if the wordlist exists
  if [ ! -f "$wordlist" ]; then
    echo "Wordlist file not found: $wordlist"
    exit 1
  fi

  #check if the 'curl' command is available
  if ! command -v curl &> /dev/null; then
    echo "curl is required but not installed. Please install curl."
    exit 1
  fi

  scandir "$baseurl" "$wordlist"
}

main "$@"
