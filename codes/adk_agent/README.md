# ADK File Agent

This project demonstrates a Google Agent Development Kit (ADK) agent capable of managing files in a sandbox directory.

## Setup

1.  **Install Dependencies**:
    ```bash
    npm install
    ```
    This will automatically patch the `@google/adk` library to ensure compatibility with recent Gemini models.

2.  **Environment Variables**:
    Ensure you have `GEMINI_API_KEY` set in your environment or `.env` file.

## Usage

Run the agent:

```bash
npx tsx src/run.ts
```

## Features

-   **Tools**:
    -   `list_files`: List files in the sandbox.
    -   `read_file`: Read file content.
    -   `write_file`: Write content to a file.
-   **Sandbox**: All file operations are restricted to the `sandbox/` directory.
-   **Model**: Configured to use `gemini-2.0-flash-exp`.

## Example Output

```
Running agent with prompt: "create hello.txt containing some text and files.txt containing the files in the parent directory"
Agent response: File hello.txt written successfully.
Agent response: File files.txt written successfully.
```
