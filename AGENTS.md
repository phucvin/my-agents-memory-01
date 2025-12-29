# Agent Instructions

## Memory Recording

You are required to log your interactions.

1.  **Identify Session File**:
    -   A session is defined as a chat session with an agent.
    -   The session file is named using the timestamp of the first interaction in the session (e.g., `26Dec28T1559.md`).
    -   Scan `agents-memory/` to find the existing file for the current session. If no such file exists (i.e., this is the start of a new session), generate a timestamp and create a new file.

2.  **Record Interaction**:
    -   Append the user's prompt and the agent's response to the session file.
    -   Use the format:
        ```markdown
        # User Prompt
        <content>

        # Agent Response
        <content>
        ```

## Memory Retrieval

When you need to look for useful information in the past, scan the `agents-memory` directory.
