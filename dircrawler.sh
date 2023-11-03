#!/bin/bash

scan_directory() {
  base_url="$1"
  wordlist="$2"

  # Loop through dirs from wordlist
  while IFS= read -r directory; do
    url="$base_url/$directory"
    response_code=$(curl -s -o /dev/null -w "%{http_code}" "$url")

    # Check if the HTTP response code is 200 (OK)
    if [ "$response_code" -eq 200 ]; then
      echo "Directory found: $url"
    fi
  done < "$wordlist"
}

main() {
  if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <base_url> <wordlist_file>"
    exit 1
  }

  base_url="$1"
  wordlist="$2"

  # Check if the wordlist exists
  if [ ! -f "$wordlist" ]; then
    echo "Wordlist file not found: $wordlist"
    exit 1
  }

  # Check if the 'curl' command is available
  if ! command -v curl &> /dev/null; then
    echo "curl is required but not installed. Please install curl."
    exit 1
  }

  scan_directory "$base_url" "$wordlist"
}

main "$@"
