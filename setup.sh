#!/bin/bash

# Set Variables
TOOL_DIR="/mnt/drive"
DISK="/dev/sdb1"  # Change this if your drive has a different partition

# Step 1: Mount the Drive
echo "[*] Mounting second drive as /mnt/drive..."
sudo mkdir -p $TOOL_DIR
sudo mount $DISK $TOOL_DIR
echo "$DISK $TOOL_DIR ext4 defaults 0 2" | sudo tee -a /etc/fstab

# Step 2: Create Tool Directories
echo "[*] Creating tool directories..."
mkdir -p $TOOL_DIR/{OSINT,Networking,Forensics,PenTesting,DevTools,ReverseEngineering}

# Step 3: Configure Package Managers
echo "[*] Configuring package managers..."
echo 'Dir::Cache "/mnt/drive/apt-cache";' | sudo tee /etc/apt/apt.conf.d/02cache
mkdir -p $TOOL_DIR/python-packages
echo "export PYTHONUSERBASE=$TOOL_DIR/python-packages" >> ~/.bashrc
source ~/.bashrc

# Step 4: Install Tools
echo "[*] Installing tools..."
cd $TOOL_DIR
git clone https://github.com/smicallef/spiderfoot.git       # OSINT
git clone https://github.com/laramies/theHarvester.git      # OSINT
git clone https://github.com/robertdavidgraham/masscan.git  # Networking
git clone https://github.com/sqlmapproject/sqlmap.git       # SQL Injection
git clone https://github.com/beefproject/beef.git          # XSS Exploitation
git clone https://github.com/EmpireProject/Empire.git      # Post-Exploitation
git clone https://github.com/NationalSecurityAgency/ghidra.git # Reverse Engineering
git clone https://github.com/radareorg/radare2.git         # Reverse Engineering
git clone https://github.com/volatilityfoundation/volatility3.git # Memory Forensics
git clone https://github.com/sleuthkit/autopsy.git         # Digital Forensics

# Step 5: Update Path
echo "[*] Updating PATH..."
echo 'export PATH=$PATH:/mnt/drive' >> ~/.bashrc
source ~/.bashrc

echo "[✔] All tools installed under $TOOL_DIR! Run them from there."
