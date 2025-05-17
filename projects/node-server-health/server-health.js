#!/usr/bin/env node

const { execSync } = require("child_process");
const fs = require("fs");
const path = require("path");

function run(cmd) {
    try {
        return execSync(cmd).toString().trim();
    } catch (err) {
        return "Unavailable";
    }
}

const timestamp = new Date().toLocaleString();

const cpu = run("top -bn1 | grep 'Cpu(s)'");
const mem = run("free -m | grep Mem");
const disk = run("df -h / | tail -1");

const entry = { timestamp, cpu, mem, disk};

const filePath = path.join(__dirname, "stats.json");
let stats = [];
if (fs.existsSync(filePath)) {
    stats = JSON.parse(fs.readFileSync(filePath));
}
stats.push(entry);

fs.writeFileSync(filePath, JSON.stringify(stats, null, 2));

console.log("=== System Health ===");
console.log(`Time: ${timestamp}`);
console.log(("CPU:"), cpu);
console.log(("Memory:"), mem);
console.log(("Disk:"), disk);
