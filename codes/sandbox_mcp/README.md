
Start https://github.com/agent-infra/sandbox:

```bash
docker run --security-opt seccomp=unconfined --rm -it -p 8080:8080 ghcr.io/agent-infra/sandbox:latest
```

Forward port 8080 and go there.

Install Gemini CLI: `npm install -g @google/gemini-cli`

Configure `~/.gemini/settings.json`:
```
{
  "mcpServers": {
    "httpServer": {
      "httpUrl": "http://localhost:8080/mcp",
      "timeout": 5000
    }
  }
}
```

Example prompts:

- Run fib(10) in sandbox
- Do not close browser after you're done
- Browse to hacker news in sandbox, and click on the second story.