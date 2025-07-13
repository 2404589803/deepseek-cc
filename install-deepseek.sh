#!/bin/bash

set -e

install_nodejs() {
    local platform=$(uname -s)
    
    case "$platform" in
        Linux|Darwin)
            echo "🚀 Installing Node.js on Unix/Linux/macOS..."
            
            echo "📥 Downloading and installing nvm..."
            curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
            
            echo "🔄 Loading nvm environment..."
            \. "$HOME/.nvm/nvm.sh"
            
            echo "📦 Downloading and installing Node.js v22..."
            nvm install 22
            
            echo -n "✅ Node.js installation completed! Version: "
            node -v # Should print "v22.17.0".
            echo -n "✅ Current nvm version: "
            nvm current # Should print "v22.17.0".
            echo -n "✅ npm version: "
            npm -v # Should print "10.9.2".
            ;;
        *)
            echo "Unsupported platform: $platform"
            exit 1
            ;;
    esac
}

# Check if Node.js is already installed and version is >= 18
if command -v node >/dev/null 2>&1; then
    current_version=$(node -v | sed 's/v//')
    major_version=$(echo $current_version | cut -d. -f1)
    
    if [ "$major_version" -ge 18 ]; then
        echo "Node.js is already installed: v$current_version"
    else
        echo "Node.js v$current_version is installed but version < 18. Upgrading..."
        install_nodejs
    fi
else
    echo "Node.js not found. Installing..."
    install_nodejs
fi

# Check if Claude Code is already installed
if command -v claude >/dev/null 2>&1; then
    echo "Claude Code is already installed: $(claude --version)"
else
    echo "Claude Code not found. Installing..."
    npm install -g @anthropic-ai/claude-code
fi

# Prompt user for API key
echo "🔑 Please enter your DeepSeek API key:"
echo "   You can get your API key from: https://platform.deepseek.com/api_keys"
echo "   Note: The input is hidden for security. Please paste your API key directly."
echo ""
read -s api_key
echo ""

if [ -z "$api_key" ]; then
    echo "⚠️  API key cannot be empty. Please run the script again."
    exit 1
fi

# Configure Claude Code to skip onboarding
echo "📝 Configuring Claude Code to skip onboarding..."
node --eval "
const fs = require('fs');
const path = require('path');
const os = require('os');

const homeDir = os.homedir(); 
const filePath = path.join(homeDir, '.claude.json');

try {
    let config = {};
    if (fs.existsSync(filePath)) {
        const content = fs.readFileSync(filePath, 'utf-8');
        config = JSON.parse(content);
    }
    
    config.hasCompletedOnboarding = true;
    fs.writeFileSync(filePath, JSON.stringify(config, null, 2), 'utf-8');
    console.log('✅ Claude Code onboarding configuration updated');
} catch (error) {
    console.error('⚠️  Error configuring Claude Code:', error.message);
}
"

# Detect current shell and determine rc file
current_shell=$(basename "$SHELL")
case "$current_shell" in
    bash)
        rc_file="$HOME/.bashrc"
        ;;
    zsh)
        rc_file="$HOME/.zshrc"
        ;;
    fish)
        rc_file="$HOME/.config/fish/config.fish"
        ;;
    *)
        rc_file="$HOME/.profile"
        ;;
esac

# Add environment variables to rc file
echo ""
echo "📝 Adding environment variables to $rc_file..."

# Remove existing Claude/Anthropic environment variables to avoid conflicts
if [ -f "$rc_file" ]; then
    # Create a backup
    cp "$rc_file" "$rc_file.backup.$(date +%Y%m%d_%H%M%S)"
    
    # Remove old environment variables
    sed -i.tmp '/^export ANTHROPIC_BASE_URL=/d' "$rc_file" 2>/dev/null || true
    sed -i.tmp '/^export ANTHROPIC_API_KEY=/d' "$rc_file" 2>/dev/null || true
    sed -i.tmp '/^export DEEPSEEK_BASE_URL=/d' "$rc_file" 2>/dev/null || true
    sed -i.tmp '/^export DEEPSEEK_API_KEY=/d' "$rc_file" 2>/dev/null || true
    sed -i.tmp '/^export OPENAI_BASE_URL=/d' "$rc_file" 2>/dev/null || true
    sed -i.tmp '/^export OPENAI_API_KEY=/d' "$rc_file" 2>/dev/null || true
    
    # Clean up temp files
    rm -f "$rc_file.tmp" 2>/dev/null || true
fi

# Add new environment variables
echo "" >> "$rc_file"
echo "# DeepSeek API environment variables for Claude Code" >> "$rc_file"
echo "export ANTHROPIC_BASE_URL=https://api.deepseek.com" >> "$rc_file"
echo "export ANTHROPIC_API_KEY=$api_key" >> "$rc_file"
echo "export DEEPSEEK_BASE_URL=https://api.deepseek.com" >> "$rc_file"
echo "export DEEPSEEK_API_KEY=$api_key" >> "$rc_file"
echo "export OPENAI_BASE_URL=https://api.deepseek.com" >> "$rc_file"
echo "export OPENAI_API_KEY=$api_key" >> "$rc_file"

echo "✅ Environment variables added to $rc_file"

echo ""
echo "🎉 DeepSeek CC installation completed successfully!"
echo ""
echo "🔄 Please restart your terminal or run:"
echo "   source $rc_file"
echo ""
echo "🚀 Then you can start using Claude Code with DeepSeek API:"
echo "   claude"
echo ""
echo "📋 Available models:"
echo "   - deepseek-chat (DeepSeek-V3-0324)"
echo "   - deepseek-reasoner (DeepSeek-R1-0528)"
echo ""
echo "💡 Tips:"
echo "   - Claude Code will now use DeepSeek API instead of Anthropic's API"
echo "   - All your conversations will be processed through DeepSeek models"
echo "   - You can still use all Claude Code features as normal"
echo ""
echo "🔗 Documentation:"
echo "   - DeepSeek API: https://platform.deepseek.com/docs"
echo "   - Claude Code: https://github.com/anthropics/claude-code" 