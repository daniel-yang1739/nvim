# llm.nvim Guide

This configuration uses [`Kurama622/llm.nvim`](https://github.com/Kurama622/llm.nvim) to interact with Trend Micro's OpenAI-compatible LLM endpoint from Neovim.

## 1. Configure Credentials

Create the local environment file from the example:

```sh
cp .env.example .env
```

Edit `.env`:

```env
LLM_TREND_MICRO_API=your-complete-api-endpoint
LLM_TREND_MICRO_KEY=your-api-token
```

Keep `.env` private. It is ignored by Git. Do not put real tokens in `.env.example` or any tracked file.

The API variable must contain the complete endpoint used by `llm.nvim`. If your provider gives you a base URL for an OpenAI-compatible API, append `/chat/completions`.

## 2. Open the Chat

From Normal mode, press:

```text
,ac
```

Type your question in the input window. For the regular chat UI, press:

```text
Ctrl-g
```

to send it.

Example:

```text
Explain the architecture of this file and identify the main entry points.
```

## 3. Select a Model

The configured models are listed in `lua/plugins/llm.lua`. They all use the Trend Micro endpoint and credentials, but send a different model name.

Inside the chat window:

- `Ctrl-m`: Open the model picker.
- `Ctrl-Shift-j`: Select the next model.
- `Ctrl-Shift-k`: Select the previous model.

The selected model is also used by the AI tools described below.

## 4. Explain Selected Code

Use this for a read-only explanation.

1. Enter Visual mode with `v`.
2. Select the code.
3. Press `,ae`.
4. Read the explanation in the result window.
5. Press `Esc` to close it.

The explanation is configured to use Traditional Chinese with Taiwan terminology.

## 5. Ask About or Modify Code

Use this when you want to ask a question about code or request a change.

### Selected code

1. Enter Visual mode with `v`.
2. Select the code.
3. Press `,aa`.
4. Enter your request.
5. Press `Enter` to submit.

Example:

```text
Find the bug in this code and propose a minimal fix. Return only the corrected code block.
```

### Current buffer

From Normal mode, press `,aa` without selecting anything. The current buffer is used as context.

### Review and apply a change

When the response contains an applicable diff:

- `d`: Display the diff.
- `y` or `Y`: Accept and apply the change.
- `n` or `N`: Reject the change.
- `Esc`: Close the window without applying it.

For reliable diffs, explicitly ask the model to return a complete code block and avoid extra explanation.

## 6. Chat Shortcuts

| Shortcut | Action |
| --- | --- |
| `Ctrl-g` | Send a chat message |
| `Ctrl-c` | Cancel the current response |
| `Ctrl-r` | Resend the previous request |
| `Ctrl-m` | Select a model |
| `Ctrl-n` | Start a new chat session |
| `Ctrl-h` | Open session history |
| `Esc` | Close the chat window |
| `Ctrl-b` / `Ctrl-f` | Scroll up / down |
| `Ctrl-u` / `Ctrl-d` | Scroll half a page up / down |

Press `?` inside the chat UI to show the plugin's built-in shortcut help.

## 7. Available Commands

These commands are useful when you prefer command-line invocation:

```vim
:LLMSessionToggle
:LLMSelectedTextHandler
:LLMAppHandler CodeExplain
:LLMAppHandler Ask
```

The configured keymaps are usually faster:

- `,ac`: Open or close chat.
- `,ae`: Explain selected code.
- `,aa`: Ask about selected code or the current buffer.

## 8. Troubleshooting

### Check the loaded endpoint

The plugin is lazy-loaded. Press `,ac` first, then run:

```vim
:lua print(vim.env.LLM_TREND_MICRO_API)
```

Check that the token exists without printing it:

```vim
:lua print(vim.env.LLM_TREND_MICRO_KEY and #vim.env.LLM_TREND_MICRO_KEY or 0)
```

### Check the endpoint independently

Test the same request with `curl`:

```sh
set -a
source ~/.config/nvim/.env
set +a

curl -i \
  -X POST "$LLM_TREND_MICRO_API" \
  -H "Authorization: Bearer $LLM_TREND_MICRO_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "gpt-5.6-luna",
    "messages": [{"role": "user", "content": "hello"}],
    "stream": false
  }'
```

- `401` or `403`: Check the token and provider permissions.
- `404`: Check the endpoint path.
- Connection error: Check network access and the endpoint URL.

If `curl` fails with the same response, the issue is with the provider request or credentials, not Neovim.

## 9. Add or Rename Models

Add models in the `trend_micro.models` list in `lua/plugins/llm.lua`:

```lua
{ name = "Display Name", model = "provider-model-name" },
```

You only need to provide `name` and `model`. The endpoint, API type, and API key are shared by the provider.

Restart Neovim after changing the plugin configuration.
