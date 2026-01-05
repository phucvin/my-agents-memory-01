# Agent Infra Sandbox MCP Integration

This guide demonstrates how to connect the [Agent Infra Sandbox](https://github.com/agent-infra/sandbox) to the [Google Gemini CLI](https://www.npmjs.com/package/@google/gemini-cli) using the Model Context Protocol (MCP).

This integration allows you to perform actions within a secure, isolated environment (including file operations, command execution, and browser automation) directly via natural language prompts in your terminal.

## Prerequisites

*   **Docker**: Required to run the sandbox container.
*   **Node.js & npm**: Required to install the Gemini CLI.

## Setup Instructions

### 1. Start the Sandbox

Launch the Agent Infra Sandbox container. This command runs it interactively and maps port 8080.

```bash
docker run --security-opt seccomp=unconfined --rm -it -p 8080:8080 ghcr.io/agent-infra/sandbox:latest
```

Once running, the sandbox (and its MCP endpoint) will be available at `http://localhost:8080`.

### 2. Install Gemini CLI

Install the Gemini CLI tool globally using npm:

```bash
npm install -g @google/gemini-cli
```

### 3. Configure Gemini CLI

Configure the CLI to connect to the sandbox's MCP server. create or edit the settings file at `~/.gemini/settings.json`:

```json
{
  "mcpServers": {
    "sandbox": {
      "httpUrl": "http://localhost:8080/mcp",
      "timeout": 5000
    }
  }
}
```

*Note: You can name the server key (here "sandbox") whatever you prefer.*

## Usage

You can now issue commands to the Gemini CLI that require sandbox access. The CLI will route relevant requests to the sandbox via MCP.

**Examples:**

*   **Code Execution:**
    ```bash
    gemini "Write a Python script to calculate the first 10 Fibonacci numbers and run it in the sandbox"
    ```

*   **Web Browsing:**
    ```bash
    gemini "Browse to news.ycombinator.com in the sandbox and tell me the top headline"
    ```

*   **Interactive Sessions:**
    ```bash
    gemini "Open a browser in the sandbox and keep it open. Navigate to google.com"
    ```
