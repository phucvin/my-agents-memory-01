# Sandbox Agent

This directory contains a prototype agent using the Google Generative AI SDK (Gemini) that can interact with a local sandbox directory.

## Features

-   **File System Tools**: The agent can list, read, and write files within the `sandbox/` directory.
-   **Security**: File access is restricted to the sandbox directory.
-   **Automatic Function Calling**: The agent automatically uses the provided tools to satisfy user requests.

## Usage

1.  Set the `GEMINI_API_KEY` environment variable.
2.  Install dependencies:
    ```bash
    pip install google-generativeai
    ```
3.  Run the agent:
    ```bash
    python main.py
    ```

## Example Output

When running the agent with the prompt:
*"create hello.txt containing some text and files.txt containing the files in the parent directory"*

The agent performs the following actions:
1.  Writes `hello.txt`.
2.  Attempts to list `..` (blocked by sandbox).
3.  Lists `.` (sandbox root).
4.  Writes `files.txt` with the list of files.

Files created in `sandbox/`:

**hello.txt**:
```text
Hello, this is a test file!
```

**files.txt**:
```text
The files in the current directory are:
hello.txt
```
