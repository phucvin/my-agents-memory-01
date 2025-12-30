# Minimal Gemini Agent in C++

This is a minimal C++ implementation of an LLM agent using the Gemini API, similar to the Python example in [Everyone Should Write an Agent](https://fly.io/blog/everyone-write-an-agent/).

## Requirements

*   C++17 compiler (g++ or clang++)
*   `curl` installed and in PATH
*   `json.hpp` (single-header JSON library from nlohmann/json) - *Already included in this directory*

## Build

```bash
make
```

## Usage

1.  Get a Gemini API Key from [Google AI Studio](https://aistudio.google.com/app/apikey).
2.  Set the `GEMINI_API_KEY` environment variable.

```bash
export GEMINI_API_KEY="your_api_key_here"
./agent
```

## Example Interaction

```
> Check connectivity to google.com
[Agent] Calling tool: ping with args {"host":"google.com"}
[Tool] Pinging google.com...
>>> The ping to google.com was successful.
```

## Implementation Details

*   It uses `curl` via `popen` to make HTTP requests (to keep dependencies minimal).
*   It implements a simple Read-Eval-Print Loop (REPL).
*   It supports a `ping` tool using Function Calling.
*   It manages context (chat history) manually using `nlohmann/json`.
