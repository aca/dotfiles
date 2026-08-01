vim.pack.add({ { src = 'https://github.com/brianhuster/live-preview.nvim.git' } })

require('livepreview.config').set({
  browser = vim.env.BROWSER or 'vivaldi',
  -- port = 3939,
})

vim.o.conceallevel = 0

-- vim.pack.add({ { src = 'https://github.com/NFrid/due.nvim.git' } })
