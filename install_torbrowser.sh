#!/bin/bash

# install_torbrowser.sh
# Download and install Tor Browser

# Define the temp directory and download URL
TEMP_DIR="/tmp/tor"
TOR_BROWSER_URL="https://www.torproject.org/dist/torbrowser/14.0.2/tor-browser-linux-x86_64-14.0.2.tar.xz"

# Define the user's desktop directory
USER_DESKTOP="/home/x/Desktop"

# Remove the existing /tmp/tor/ directory if it exists
echo "Cleaning up any previous installation in /tmp/tor..."
rm -rf ${TEMP_DIR}

# Create a temporary directory for the installation
mkdir -p ${TEMP_DIR}
cd ${TEMP_DIR} || exit

# Download the Tor Browser tarball
echo "Downloading Tor Browser version 14.0.2..."
if ! curl -# -fLO "${TOR_BROWSER_URL}"; then
    echo
    echo "A problem occurred when downloading Tor Browser"
    echo "Please try again"
    echo
    exit 1
fi

# Extract the downloaded tarball
echo "Extracting tor-browser-linux-x86_64-14.0.2.tar.xz..."
tar -xf "tor-browser-linux-x86_64-14.0.2.tar.xz"
rm "tor-browser-linux-x86_64-14.0.2.tar.xz"

# Move into the extracted directory
cd tor-browser/ || exit

# Ensure the start-tor-browser.desktop file is executable
chmod +x ./start-tor-browser.desktop

# Run the updater before launching Tor Browser
echo "Running Tor Browser updater..."
./Browser/updater

# Wait for 10 seconds before launching the browser
echo "Waiting for 10 seconds..."
sleep 10

# Create a symbolic link to the start-tor-browser.desktop in the user's Desktop directory
echo "Creating symbolic link for start-tor-browser.desktop on user's Desktop..."
ln -s ${TEMP_DIR}/tor-browser/Browser/start-tor-browser.desktop ${USER_DESKTOP}/start-tor-browser.desktop

# Launch Tor Browser using the desktop entry in the background
echo "Launching Tor Browser..."
./start-tor-browser.desktop 
