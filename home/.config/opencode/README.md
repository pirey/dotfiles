# OpenCode Token Optimization Guide

## Overview

This document summarizes token optimization strategies for OpenCode (Go subscription).

---

## 1. Token Optimization Settings

### Disable Snapshots
Snapshots track file changes for `/undo` functionality. If you use Git, this is redundant.
```json
"snapshot": false
```

### Enable Compaction
Keeps context window manageable by summarizing old conversation history.
```json
"compaction": {
  "auto": true,
  "prune": true,
  "reserved": 10000
}
```
- **auto**: Auto-summarizes when context fills up
- **prune**: Removes verbose tool outputs from history (biggest token saver)
- **reserved**: Safety buffer (tokens) for compaction to work

### Set a Small Model
Use a cheap model for lightweight tasks like title generation.
```json
"small_model": "opencode-go/qwen3.5-plus"
```

### Lower Verbosity
Configure `textVerbosity: "low"` on your model to reduce output token count.

---

## 2. Built-in Tools and Token Costs

Tools consume tokens in two ways:
- **Tool definitions**: ~500-1000 tokens total (one-time, baked into system prompt)
- **Tool execution**: Per-call cost (input + output appended to conversation history)

| Tool | Typical Token Cost per Call |
|------|----------------------------|
| `read` | ~2000-3000 tokens per 500-line file |
| `bash` | ~50-2000+ tokens (depends on output) |
| `grep` | ~100-500 tokens (matching lines) |
| `glob` | ~50-200 tokens (file paths) |
| `edit` / `write` | ~100-500 tokens |
| `lsp` | ~200-1000 tokens |
| `webfetch` | ~500-3000 tokens (full page content) |
| `websearch` | ~200-800 tokens |
| `todowrite` | ~50-200 tokens |
| `question` | ~100-300 tokens |
| `apply_patch` | ~100-500 tokens |
| `skill` | ~200-1000 tokens |

**Biggest offenders**: `read` (large files), `bash` (verbose output), `webfetch` (full pages).

---

## 3. LSP (Language Server Protocol)

LSP gives the AI IDE-like code intelligence: go-to-definition, find references, hover info, diagnostics.

**Token impact**:
- LSP costs **nothing** just by being enabled
- Costs tokens when diagnostics are fed back after edits (~500-2000 tokens per edit cycle if there are errors)
- Explicit LSP tool calls: ~200-1000 tokens per call
- **Clean code = near zero cost**. Lots of existing diagnostics = adds up fast

**Verdict**: Keep it enabled if your codebase compiles cleanly.

---

## 4. Model Selection Behavior

### Main Model Priority (on startup):
1. `--model` CLI flag (highest)
2. `"model"` in config file
3. Last used model (from previous session)
4. Internal default (first available model)

### Small Model:
- Automatic by default: picks cheapest model from same provider
- Falls back to main model if no cheaper option found
- Override by explicitly setting `"small_model"` in config

---

## 5. OpenCode Go Model Recommendations

Go is a $10/mo subscription with a **$60/month usage cap**. Model choice matters.

### Most Balanced (Daily Driver)
- **Model**: `opencode-go/qwen3.6-plus`
- **Why**: Excellent coding ability, fast, ~16k requests/month under Go limits

### Smartest (Complex Tasks)
- **Model**: `opencode-go/glm-5.1` or `opencode-go/kimi-k2.6`
- **Why**: Deepest reasoning in Go lineup. Use sparingly (~4-5k requests/month)

### Best Small Model
- **Model**: `opencode-go/qwen3.5-plus` or `opencode-go/deepseek-v4-flash`
- **Why**: Extremely cheap. Maximizes request quota for lightweight tasks (~50k-158k requests/month)

---

## 6. Final Config

```json
{
  "$schema": "https://opencode.ai/config.json",
  "model": "opencode-go/qwen3.6-plus",
  "small_model": "opencode-go/qwen3.5-plus",
  "snapshot": false,
  "compaction": {
    "auto": true,
    "prune": true,
    "reserved": 10000
  },
  "mcp": {
    "fff": {
      "type": "local",
      "command": ["fff-mcp"],
      "enabled": true
    }
  }
}
```

Location: `~/.config/opencode/opencode.json` (tracked in this dotfiles repo at `home/.config/opencode/opencode.json`)
