#!/bin/bash

set -e

GREEN='\033[0:32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

log_dir="./logs"
build_dir="./build"
deploy_dir="./deployed"
log_file="$log_dir/pipeline_$(date +%F_%T).log"
rollback="./rollback"
repo_root=$(git rev-parse --show-toplevel)

mkdir -p "$log_dir" "$build_dir" "$deploy_dir" "$rollback"

log() {
    echo -e "$1" | tee -a "$log_file"
}

status() {
    if [ "$1" -eq 0 ]; then
        log "${GREEN} $2 succeeded${NC}"
    else
        log "${RED} $2 failed${NC}"
        exit 1
    fi

}

test() {
    log "Running tests!"
    if [ -f fail_tests.flag ]; then
        log "${YELLOW}Tests failed.${NC}"
        return 1
    else
        log "Tests passed!"
        return 0
    fi
}

# ==== Update DB ====

log "${YELLOW} Pulling latest code...${NC}"
git pull >> "$log_file" 2>&1
status $? "Git pull"

# ==== Run tests ====

test 
status 0 "Tests"

# === Set up the build ===

timestamp=$(date +%Y-%m-%d_%H-%M)

project_root="${repo_root}/projects/pipeline-sim/"

tar -czf "${build_dir}/artifact${timestamp}.tar.gz" \
"${project_root}/project" >> "$log_file" 2>&1

status $? "build"

# === Deploy build ====

# == Rolling back == 
log "${YELLOW} Copying rollback${NC}"
shopt -s nullglob
files=("${deploy_dir}"/*)

if [ ${#files[@]} -gt 0 ]; then
    mv "${deploy_dir}"/* "${rollback}" >> "$log_file" 2>&1
    status $? "rollback"
else
    log "${YELLOW}No deployed files to roll back.${NC}"
fi
shopt -u nullglob

# == Deploying ==

log "${YELLOW} Deploying artifact...${NC}"
mv "build/artifact${timestamp}.tar.gz" "${deploy_dir}" >> "$log_file" 2>&1
status $? "deploy"
