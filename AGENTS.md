# Agent Instructions

## Memory Recording

You are required to log your interactions.

1.  **Initialize Log File**:
    -   At the beginning of processing a prompt, generate a timestamp in the format `DDMonYYTHHmm` (e.g., `26Dec28T1559`).
    -   Create a new file in the `agents-memory/` directory named `<timestamp>.md`.

2.  **Record Prompt**:
    -   Write the user's prompt to this file.

3.  **Execute Task**:
    -   Perform the task requested by the user as usual.

4.  **Record Response**:
    -   Upon completion of the task, append the full detailed response provided to the user to the same log file. Ensure the file is well-formatted using Markdown.
