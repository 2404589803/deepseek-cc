# DeepSeek CC

[English](README.md) | **中文**

使用 DeepSeek 的最新模型驱动您的 Claude Code，低成本享受强大 AI 助手。

## 功能特性

- 🚀 **自动安装**：自动安装 Node.js v22 和 Claude Code
- 🔑 **API 密钥配置**：安全地提示并存储您的 DeepSeek API 密钥
- 🔧 **环境变量配置**：配置 Claude Code 使用 DeepSeek API 而非 Anthropic API
- 🐚 **多 Shell 支持**：自动检测并配置 bash、zsh、fish 或默认配置文件
- ✅ **跳过引导**：自动配置 Claude Code 跳过新手引导流程
- 💰 **成本效益**：使用 DeepSeek 的实惠 API 定价享受 Claude Code 界面

## 系统要求

- Unix/Linux/macOS 操作系统
- curl（用于下载 nvm 和进行 API 调用）
- DeepSeek API 密钥（在 [platform.deepseek.com](https://platform.deepseek.com/api_keys) 获取）

## 快速安装

1. **获取您的 DeepSeek API 密钥**：
   - 访问 [DeepSeek 开放平台](https://platform.deepseek.com/api_keys)
   - 右上角用户中心 → API Key 管理 → 新建 API Key

2. **运行安装脚本**：
   ```bash
   bash -c "$(curl -fsSL https://raw.githubusercontent.com/2404589803/deepseek-cc/main/install-deepseek.sh)"
   ```

3. **按提示输入您的 API 密钥**

4. **重启终端** 或运行：
   ```bash
   source ~/.bashrc  # 或 ~/.zshrc, ~/.profile 等
   ```

5. **开始使用 Claude Code 与 DeepSeek**：
   ```bash
   claude
   ```

## 环境变量

脚本配置以下环境变量，将 Claude Code 重定向到使用 DeepSeek API：

- `ANTHROPIC_BASE_URL`: https://api.deepseek.com
- `ANTHROPIC_API_KEY`: 您的 DeepSeek API 密钥
- `DEEPSEEK_BASE_URL`: https://api.deepseek.com
- `DEEPSEEK_API_KEY`: 您的 DeepSeek API 密钥
- `OPENAI_BASE_URL`: https://api.deepseek.com（用于 OpenAI SDK 兼容性）
- `OPENAI_API_KEY`: 您的 DeepSeek API 密钥

## 可用模型

- **deepseek-chat**: DeepSeek-V3-0324（通用对话模型）
- **deepseek-reasoner**: DeepSeek-R1-0528（推理模型）

## 工作原理

DeepSeek CC 的工作原理：
1. 安装 Claude Code（Anthropic 的官方 CLI 工具）
2. 配置环境变量将 API 调用从 Anthropic 重定向到 DeepSeek
3. 由于 DeepSeek 使用 OpenAI 兼容的 API 格式，Claude Code 可以无缝工作
4. 所有对话都通过 DeepSeek 的模型处理，享受 DeepSeek 的定价

## 使用方法

安装后，像正常使用 Claude Code 一样：

```bash
claude
```

Claude Code 现在将使用 DeepSeek 的 API 而非 Anthropic 的，为您提供：
- 访问 DeepSeek 的强大模型
- 相比 Anthropic 定价更低的成本
- 相同的 Claude Code 界面和功能
- 所有 Claude Code 命令和功能

## 手动 API 使用

您也可以直接使用 DeepSeek API：

### 使用 curl

```bash
curl https://api.deepseek.com/chat/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $DEEPSEEK_API_KEY" \
  -d '{
    "model": "deepseek-chat",
    "messages": [
      {"role": "system", "content": "你是一个有用的助手。"},
      {"role": "user", "content": "你好！"}
    ],
    "stream": false
  }'
```

### 使用 Node.js 和 OpenAI SDK

```javascript
import OpenAI from 'openai';

const client = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
  baseURL: process.env.OPENAI_BASE_URL
});

const completion = await client.chat.completions.create({
  model: 'deepseek-chat',
  messages: [
    { role: 'system', content: '你是一个有用的助手。' },
    { role: 'user', content: '你好！' }
  ]
});

console.log(completion.choices[0].message.content);
```

## 问题排查

### Claude Code 无法工作
- 确保安装后重启了终端
- 检查环境变量是否已设置：`echo $ANTHROPIC_API_KEY`
- 验证您的 DeepSeek API 密钥是否有效

### Node.js 安装问题
- 确保 curl 已安装并正常工作
- 检查网络连接
- 确保对主目录有写权限

### 环境变量不生效
- 运行脚本后重启终端
- 检查变量是否添加到了正确的 shell 配置文件
- 在 [platform.deepseek.com](https://platform.deepseek.com/api_keys) 验证 API 密钥是否有效

## 文档

- [DeepSeek API 文档](https://platform.deepseek.com/docs)
- [DeepSeek API 密钥管理](https://platform.deepseek.com/api_keys)
- [Claude Code 文档](https://github.com/anthropics/claude-code)

## 许可证

本项目基于 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

## 贡献

欢迎提交问题和功能请求！ 