#!/usr/bin/env node

const { execSync } = require("child_process");

const currentDir = execSync("pwd").toString();
console.log("Current directory:", currentDir);
