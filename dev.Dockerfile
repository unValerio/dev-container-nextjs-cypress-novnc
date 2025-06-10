# Use Ubuntu 24.04 as the base image
FROM ubuntu:24.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install locales and set to en_US.UTF-8
RUN apt-get update && apt-get install -y locales && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8

# Install basic dependencies, Node.js, and VNC/Cypress dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    sudo \
    wget \
    gnupg \
    # VNC and noVNC dependencies
    tigervnc-standalone-server \
    websockify \
    fluxbox \
    xterm \
    # Cypress dependencies
    libgtk2.0-0 \
    libgtk-3-0 \
    libgbm-dev \
    libnotify-dev \
    libnss3 \
    libxss1 \
    libasound2t64 \
    libxtst6 \
    xauth \
    xvfb \
    # Node.js setup
    && curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install noVNC
RUN mkdir -p /opt/novnc \
    && wget -qO- https://github.com/novnc/noVNC/archive/refs/tags/v1.4.0.tar.gz | tar xz --strip 1 -C /opt/novnc \
    && ln -s /opt/novnc/vnc.html /opt/novnc/index.html

# Create a non-root user
RUN useradd -m -s /bin/bash vscode \
    && echo "vscode ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/vscode

# Create xstartup script for VNC
RUN mkdir -p /home/vscode/.vnc && \
    echo '#!/bin/sh' > /home/vscode/.vnc/xstartup && \
    echo 'unset SESSION_MANAGER' >> /home/vscode/.vnc/xstartup && \
    echo 'unset DBUS_SESSION_BUS_ADDRESS' >> /home/vscode/.vnc/xstartup && \
    echo 'xsetroot -solid grey' >> /home/vscode/.vnc/xstartup && \
    echo 'xterm -geometry 80x24+10+10 -ls -title "$VNCDESKTOP Desktop" &' >> /home/vscode/.vnc/xstartup && \
        echo 'fluxbox' >> /home/vscode/.vnc/xstartup && \
    chmod +x /home/vscode/.vnc/xstartup && \
    chown -R vscode:vscode /home/vscode/.vnc

# Set the working directory
WORKDIR /workspace

# Switch to the non-root user
USER vscode

# Expose ports for Next.js app and noVNC
EXPOSE 3000 6080

# Set default command
CMD ["/bin/bash"]
