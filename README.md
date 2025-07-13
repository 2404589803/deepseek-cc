# DeepSeek CC

**English** | [中文](README-zh.md)

Use DeepSeek's latest models to power your Claude Code at low cost.

## Features

- 🚀 **Automatic Setup**: Installs Node.js v22 and Claude Code automatically
- 🔑 **API Key Configuration**: Securely prompts for and stores your DeepSeek API key
- 🔧 **Environment Variables**: Configures Claude Code to use DeepSeek API instead of Anthropic's
- 🐚 **Multi-shell Support**: Automatically detects and configures bash, zsh, fish, or default profile
- ✅ **Onboarding Skip**: Automatically configures Claude Code to skip the onboarding process
- 💰 **Cost Effective**: Use DeepSeek's affordable API pricing with Claude Code interface

## Prerequisites

- Unix/Linux/macOS operating system
- curl (for downloading nvm and making API calls)
- A DeepSeek API key (get one at [platform.deepseek.com](https://platform.deepseek.com/api_keys))

## Quick Installation

1. **Get your DeepSeek API key**:
   - Visit [DeepSeek Open Platform](https://platform.deepseek.com/api_keys)
   - Go to User Center (top right) → API Key Management → Create New API Key

2. **Run the installation script**:
   ```bash
   bash -c "$(curl -fsSL https://raw.githubusercontent.com/2404589803/deepseek-cc/main/install-deepseek.sh)"
   ```

3. **Enter your API key when prompted**

4. **Restart your terminal** or run:
   ```bash
   source ~/.bashrc  # or ~/.zshrc, ~/.profile, etc.
   ```

5. **Start using Claude Code with DeepSeek**:
   ```bash
   claude
   ```

## Environment Variables

The script configures the following environment variables to redirect Claude Code to use DeepSeek API:

- `ANTHROPIC_BASE_URL`: https://api.deepseek.com
- `ANTHROPIC_API_KEY`: Your DeepSeek API key
- `DEEPSEEK_BASE_URL`: https://api.deepseek.com
- `DEEPSEEK_API_KEY`: Your DeepSeek API key
- `OPENAI_BASE_URL`: https://api.deepseek.com (for OpenAI SDK compatibility)
- `OPENAI_API_KEY`: Your DeepSeek API key

## Available Models

- **deepseek-chat**: DeepSeek-V3-0324 (General chat model)
- **deepseek-reasoner**: DeepSeek-R1-0528 (Reasoning model)

## How It Works

DeepSeek CC works by:
1. Installing Claude Code (Anthropic's official CLI tool)
2. Configuring environment variables to redirect API calls from Anthropic to DeepSeek
3. Since DeepSeek uses OpenAI-compatible API format, Claude Code works seamlessly
4. All your conversations are processed through DeepSeek's models at DeepSeek's pricing

## Usage

After installation, simply use Claude Code as normal:

```bash
claude
```

Claude Code will now use DeepSeek's API instead of Anthropic's, giving you:
- Access to DeepSeek's powerful models
- Lower costs compared to Anthropic's pricing
- Same Claude Code interface and features
- All Claude Code commands and functionality

## Manual API Usage

You can also use the DeepSeek API directly:

### Using curl

```bash
curl https://api.deepseek.com/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $DEEPSEEK_API_KEY" \
  -d '{
    "model": "deepseek-chat",
    "messages": [
      {"role": "system", "content": "You are a helpful assistant."},
      {"role": "user", "content": "Hello!"}
    ],
    "stream": false
  }'
```

### Using Node.js with OpenAI SDK

```javascript
import OpenAI from 'openai';

const client = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
  baseURL: process.env.OPENAI_BASE_URL
});

const completion = await client.chat.completions.create({
  model: 'deepseek-chat',
  messages: [
    { role: 'system', content: 'You are a helpful assistant.' },
    { role: 'user', content: 'Hello!' }
  ]
});

console.log(completion.choices[0].message.content);
```

## Troubleshooting

### Claude Code Not Working
- Make sure you restarted your terminal after installation
- Check that environment variables are set: `echo $ANTHROPIC_API_KEY`
- Verify your DeepSeek API key is valid

### Node.js Installation Issues
- Ensure curl is installed and working
- Check your internet connection
- Make sure you have write permissions to your home directory

### Environment Variables Not Working
- Restart your terminal after running the script
- Check that the variables were added to the correct shell configuration file
- Verify the API key is valid at [platform.deepseek.com](https://platform.deepseek.com/api_keys)

## Documentation

- [DeepSeek API Documentation](https://platform.deepseek.com/docs)
- [DeepSeek API Keys Management](https://platform.deepseek.com/api_keys)
- [Claude Code Documentation](https://github.com/anthropics/claude-code)

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

## Contributing

Feel free to submit issues and enhancement requests! 