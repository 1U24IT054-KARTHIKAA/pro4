#!/bin/bash

# SELinux Access Denial Practical
# Student Name:KARTHIKAA M
# Register Number:1U24IT054

echo "===== SELinux Status ====="
getenforce
sestatus

echo "===== Creating Web Directory ====="
sudo mkdir -p "$WEB_DIR"
echo "===== Creating HTML File ====="
echo "<html><body><h1>SELinux Practical Test</h1></body></html>" | sudo tee "$HTML_FILE" > /dev/null

echo "===== Setting Linux Permissions ====="
sudo chmod 755 "$WEB_DIR"
sudo chmod 644 "$HTML_FILE"

echo "===== Checking Initial Context ====="
ls -Zd "$WEB_DIR"
ls -Z "$HTML_FILE"


echo "===== Assigning Wrong SELinux Context ====="
sudo chcon -t default_t "$WEB_DIR"
sudo chcon -t default_t "$HTML_FILE"
echo "===== Checking Wrong Context ====="
ls -Zd "$WEB_DIR"
ls -Z "$HTML_FILE"

echo "===== Checking AVC Denials ====="
sudo ausearch -m AVC -ts recent 2>/dev/null
echo "===== Correcting SELinux Context ====="
sudo restorecon -Rv "$WEB_DIR"

echo "===== Checking Correct Context ====="
ls -Zd "$WEB_DIR"
ls -Z "$HTML_FILE"


echo "===== Practical Completed ====="
