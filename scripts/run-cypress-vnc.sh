#!/bin/bash

# Set the VNC password
export VNC_PASSWORD=password
mkdir -p ~/.vnc
echo $VNC_PASSWORD | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# Start the VNC server in the background
echo "Starting VNC server..."
vncserver :1 -geometry 1280x720 -depth 24

# Start noVNC in the background
echo "Starting noVNC..."
websockify --web /opt/novnc/ 6080 localhost:5901 &

# Set the display for Cypress to use the VNC server
export DISPLAY=:1

# Start the Next.js dev server in the background
echo "Starting Next.js dev server..."
npm run dev &

# Wait for the dev server to be ready
# (A more robust solution would use a tool like wait-on)
sleep 10

# Start Cypress
echo "Starting Cypress..."
npx cypress open
