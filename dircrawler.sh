#!/bin/bash

# Function to perform directory traversal
scan_directory() {
  base_url="$1"
  wordlist="$2"

  while IFS= read -r directory; do
    url="$base_url/$directory"
    response_code=$(curl -s -o /dev/null -w "%{http_code}" "$url")

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

  if [ ! -f "$wordlist" ]; then
    echo "Wordlist file not found: $wordlist"
    exit 1
  }

  if ! command -v curl &> /dev/null; then
    echo "curl is required but not installed. Please install curl."
    exit 1
  }

  scan_directory "$base_url" "$wordlist"
}

main "$@"
