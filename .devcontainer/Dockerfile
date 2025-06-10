# Use Ubuntu 24.04 as the base image
FROM ubuntu:24.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

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
    # Cypress dependencies
    libgtk2.0-0 \
    libgtk-3-0 \
    libgbm-dev \
    libnotify-dev \
    libgconf-2-4 \
    libnss3 \
    libxss1 \
    libasound2 \
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
    && wget -qO- https://github.com/novnc/noVNC/archive/refs/tags/v1.4.0.tar.gz | tar xz --strip 1 -C /opt/novnc

# Create a non-root user
RUN useradd -m -s /bin/bash vscode \
    && echo "vscode ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/vscode

# Set the working directory
WORKDIR /home/vscode/project

# Copy project files as vscode user
COPY --chown=vscode:vscode . .

# Switch to the non-root user
USER vscode

# Expose ports for Next.js app and noVNC
EXPOSE 3000 6080

# Set default command
CMD ["/bin/bash"]
