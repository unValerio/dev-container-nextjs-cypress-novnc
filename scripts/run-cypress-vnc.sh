#!/bin/bash

# Set up VNC password file (required by vncserver)
mkdir -p ~/.vnc
touch ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

# Start the VNC server in the background
echo "Starting VNC server..."
vncserver :1 -geometry 1280x720 -depth 24 -SecurityTypes None

# Start noVNC in the background
echo "Starting noVNC..."
echo "
>>> Open http://localhost:6080/vnc.html to view the Cypress UI <<<
"
websockify --web /opt/novnc/ 6080 localhost:5901 &

# Set the display for Cypress to use the VNC server
export DISPLAY=:1

# Start the Next.js dev server in the background
echo "Starting Next.js dev server..."
npm run dev &

# Wait for the dev server to be ready
# (A more robust solution would use a tool like wait-on)
sleep 10

# Verify Cypress installation and install if needed
echo "Verifying Cypress installation..."
if ! npx cypress verify; then
    echo "Cypress not verified. Attempting to install..."
    npx cypress install
fi

# Start Cypress
echo "Starting Cypress..."
npx cypress open
