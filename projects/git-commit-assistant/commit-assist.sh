#!/bin/bash

# Step 1: Add all the changes
git add .

# Step 2: Choose a commit type
echo "Select commit type:"
options=("Feature" "Bugfix" "Docs" "Other")
select opt in "${options[@]}"
do
    case $opt in
        "Feature"|"Bugfix"|"Docs"|"Other")
            break
            ;;
        *)
            echo "Invalid option"
            ;;
    esac
done

#Step 3: Ask for a message
read -p "Short commit message: " message

# Step 4: Save to local log file

timestamp=$(date "+%Y-%m-%d %H:%M:%S")
logfile="$HOME/.commit-log.txt"

echo "[$timestamp][$category] $message" >> "$logfile" && echo "Logging completed!"

# Step 5: Commit
git commit -m "$message"
echo "Commited: $message"


