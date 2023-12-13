-- Lua
require('gitblame').setup()
vim.g.gitblame_display_virtual_text = 0 -- Disable virtual text
vim.g.gitblame_message_template = '<author> • <date>'
vim.g.gitblame_date_format = '%r'
