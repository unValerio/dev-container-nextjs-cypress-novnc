# Dev Container with Next.js, Cypress, and noVNC

This project provides a fully configured VS Code Dev Container for developing and testing a Next.js application. It comes with Cypress for end-to-end testing and a VNC/noVNC setup that allows you to view and interact with the Cypress test runner's UI directly from your local machine's browser.

## Features

-   **Base Image**: Ubuntu 24.04
-   **Core Technologies**:
    -   Next.js (with TypeScript, ESLint, and Tailwind CSS)
    -   Node.js (LTS)
-   **Testing**:
    -   Cypress for end-to-end testing.
    -   Visual access to the Cypress UI via noVNC.
-   **Automation**: A single script to launch the entire environment (VNC, noVNC, Next.js server, and Cypress).

## Project Structure

```
.
├── .devcontainer/
│   ├── devcontainer.json   # VS Code Dev Container configuration
│   └── Dockerfile          # Defines the container image and dependencies
├── cypress/
│   ├── e2e/
│   │   └── home.cy.ts      # Sample Cypress test
│   └── support/
├── scripts/
│   └── run-cypress-vnc.sh  # Orchestration script for the testing environment
├── src/                    # Next.js application source code
├── package.json            # Project dependencies and scripts
├── cypress.config.ts       # Cypress configuration
└── ...
```

## How to Use This Dev Environment

### Prerequisites

-   [Docker Desktop](https://www.docker.com/products/docker-desktop/)
-   [Visual Studio Code](https://code.visualstudio.com/)
-   [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) for VS Code

### Getting Started

1.  **Clone the Repository**:
    Clone this repository to your local machine.

2.  **Reopen in Container**:
    Open the project folder in VS Code. You should see a notification in the bottom-right corner prompting you to "Reopen in Container." Click it.

    VS Code will now build the Docker image as defined in the `Dockerfile`. This might take a few minutes on the first run as it downloads the base image and installs all dependencies.

3.  **Automatic Setup**:
    Once the container is built and running, the `postCreateCommand` in `devcontainer.json` will automatically:
    -   Run `npm install` to install all the Node.js dependencies.
    -   Make the orchestration script (`scripts/run-cypress-vnc.sh`) executable.

4.  **Launch the Testing Environment**:
    Open a new terminal in VS Code (which will now be a terminal inside the running container). Run the following command:

    ```bash
    npm run cypress:open:vnc
    ```

    This command executes the `run-cypress-vnc.sh` script, which will:
    -   Start the TigerVNC server.
    -   Start the noVNC web client.
    -   Start the Next.js development server.
    -   Launch the Cypress test runner.

5.  **View the Cypress UI**:
    Open your local web browser and navigate to:
    [http://localhost:6080](http://localhost:6080)

    You will see the noVNC interface, which displays the desktop environment from the container, including the Cypress test runner window. You can now interact with Cypress as if it were running locally.

## Available Scripts

-   `npm run dev`: Starts the Next.js development server.
-   `npm run build`: Builds the Next.js application for production.
-   `npm run start`: Starts a production Next.js server.
-   `npm run lint`: Lints the codebase.
-   `npm run cypress:open`: Opens the Cypress test runner (without VNC).
-   `npm run cypress:run`: Runs Cypress tests headlessly.
-   `npm run cypress:open:vnc`: The main command to launch the full visual testing environment.
