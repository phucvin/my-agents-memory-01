# Agent Instructions

## Memory Recording

You are required to log your interactions in a single session file.

1.  **Identify Session File**:
    -   Check for an existing file in `agents-memory/` named `session-<JULES_SESSION_ID>.md`.
    -   If it does not exist, create it.

2.  **Session Summary**:
    -   The top of the file must contain a section `# Session Summary`.
    -   Update this summary briefly after each interaction to reflect the current state or goal of the session.

3.  **Record Interaction**:
    -   Append a new section for the current turn.
    -   Use `## Turn <Timestamp>` or `## User Prompt` as a header.
    -   Log the full **User Prompt**.
    -   After executing the task, append the **Agent Response**.

## Memory Retrieval

When you need to look for useful information in the past, scan the `agents-memory` directory.
