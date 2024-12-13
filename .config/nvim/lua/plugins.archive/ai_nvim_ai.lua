vim.cmd.packadd "nvim.ai"

require('ai').setup({
  --provider = "snova",
  --provider = "hyperbolic",
  --provider = "cerebras",
  --provider = "gemini",
  --provider = "mistral",
  provider = "anthropic",
  --provider = "deepseek",
  --provider = "groq",
  --provider = "cohere",
})
