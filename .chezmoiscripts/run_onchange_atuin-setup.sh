#!/bin/bash
# Idempotent atuin login script

set -euo pipefail

# Check if atuin is logged in
if atuin status 2>&1 | grep -q "You are not logged in to a sync server"; then
    echo "Atuin is not logged in. Attempting to log in..."
    
    # Check if required environment variables are set
    if [[ -z "${ATUIN_PW:-}" ]]; then
        echo "Error: ATUIN_PW environment variable is not set"
        exit 1
    fi
    
    if [[ -z "${ATUIN_KEY:-}" ]]; then
        echo "Error: ATUIN_KEY environment variable is not set"
        exit 1
    fi
    
    atuin login -u crown421 -p $ATUIN_PW -k $ATUIN_KEY
    
    echo "Login attempt completed."
else
    echo "Atuin is already logged in."
fi

# Verify login status
if atuin status 2>&1 | grep -q "You are not logged in to a sync server"; then
    echo "Error: Login failed"
    exit 1
else
    echo "Atuin login verification successful."
fi
