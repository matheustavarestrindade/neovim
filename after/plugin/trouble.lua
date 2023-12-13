require("trouble").setup({
	icons = true,
	use_diagnostic_signs = true
})
vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>",
	{ silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>dd", "<cmd>TroubleToggle document_diagnostics<cr>",
	{ silent = true, noremap = true }
)
vim.keymap.set("n", "<leader>df", vim.diagnostic.open_float)

vim.diagnostic.config({
	virtual_text = false,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
	signs = true,
	underline = true,
	update_in_insert = true,
	severity_sort = false,
})
