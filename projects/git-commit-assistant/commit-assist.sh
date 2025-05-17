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
repo_root=$(git rev-parse --show-toplevel)
if [[ -z "$repo_root" ]]; then
    echo "Not inside a Git repository"
    exit 1
fi

logfile="$repo_root/logs/.commit-log.txt"

echo "[$timestamp][$opt] $message" >> "$logfile" && echo "Logging completed!"

# Step 5: Commit
git commit -m "$message"
echo "Commited: $message"

# Step 6: Push

git push


