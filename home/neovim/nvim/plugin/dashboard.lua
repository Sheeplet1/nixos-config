vim.pack.add({ "https://github.com/nvimdev/dashboard-nvim" })

---Provides the startup dashboard configured below.
local dashboard = require("dashboard")

---Displays the chosen compact Luffy portrait without relying on terminal image protocols.
---
---Each row remains separate because dashboard-nvim centers header entries individually.
---@type string[]
local luffy_header = {
	[[⣟⣯⣟⣯⡇⠀⣿⢩⣛⡼⣏⠀⠈⠋⠀⣈⡷⣙⢎⡳⣙⢮⣙⢮⣙⢎⡳⣙⢾⣿]],
	[[⢿⡾⣽⡞⣷⣤⣏⡳⡜⡼⠗⠁⢀⠀⠙⢧⠳⣍⢞⡱⣭⠲⣍⠶⣩⢞⡱⡭⣾⣿]],
	[[⠈⠻⠧⢿⣧⣿⠶⣵⢻⢞⡷⢲⡟⡶⢴⡭⢿⣜⣮⡱⢎⡳⣍⢞⡱⢮⡱⣳⣿⣽]],
	[[⠀⣰⣶⡏⢷⣈⣿⣸⣇⣾⣸⣿⣾⣹⣆⡹⡎⡶⢇⡿⣹⢷⣾⣈⠷⣇⢷⣿⣿⣹]],
	[[⣾⣻⣭⣿⣾⣿⣿⣟⣿⣿⡿⣽⡿⣿⢿⣿⣿⣿⣾⣶⣵⣾⠲⣭⢳⣞⣾⡿⣷⣿]],
	[[⣿⣿⣿⣯⣷⣿⣿⠿⢝⠚⠋⠉⠉⠉⠙⠚⠛⡾⢿⣿⣻⣿⣿⣶⣏⠶⣩⠿⣿⡈]],
	[[⣿⣟⣿⣻⣿⡏⠀⠀⠀⠳⡀⠀⠀⠀⠀⠰⠊⠀⠀⠈⠙⠳⣿⣿⣿⣿⣧⣻⣿⣿]],
	[[⠘⢻⣿⣿⣽⡇⠈⠧⣄⠀⠀⠀⠀⠀⠀⢀⣄⡤⠴⠚⠀⠀⠀⠙⢿⣷⡿⣿⣿⣿]],
	[[⠀⠠⢈⢛⣿⠀⠚⠉⠉⠱⣼⡷⠀⠀⠀⠀⠉⠉⠑⠶⠀⠀⠀⠀⠀⠻⣿⣿⣾⢿]],
	[[⠀⠡⠈⠉⠹⡀⠀⠀⡄⠀⣸⡀⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⣰⣿⣯⣿⢿]],
	[[⠀⠁⢶⣶⠀⢷⠀⠀⠉⠉⠀⠈⠉⠶⠆⠈⠀⠀⠀⠀⠀⠀⠀⠀⣸⣿⣿⣿⣾⣿]],
	[[⠀⠡⢸⢹⠏⡍⠓⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣺⡟⠋⠉⢹⢭⢣]],
	[[⠀⠀⢸⣹⡏⠭⠭⠭⠙⣲⣦⣤⣤⣀⣀⣀⣀⣤⣤⣶⣞⠉⠙⠛⠷⢀⣀⠘⣎⠧]],
	[[⢁⣈⣀⣀⢀⣀⣀⣀⣼⠟⠹⢿⣯⣟⣿⣻⡿⠿⠛⢿⣿⣦⡀⠀⠀⠀⠀⠉⠉⠘]],
	"", -- Separate the portrait from the Neovim wordmark.
	[[███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗]],
	[[████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║]],
	[[██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║]],
	[[██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║]],
	[[██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║]],
	[[╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
	"", -- Keep the center actions visually distinct from the complete header.
	"",
}

---Shows a replaceable placeholder quote beneath the dashboard actions.
---
---Keep the initial empty row when changing the quote so the footer remains visually separated.
---@type string[]
local luffy_footer = {
	"",
	[["I'm gonna be King of the Pirates!" — Monkey D. Luffy]],
}

dashboard.setup({
	theme = "doom",
	config = {
		header = luffy_header,
		center = {
			{
				icon = " ",
				icon_hl = "DashboardIcon",
				desc = "Find Files",
				desc_hl = "DashboardDesc",
				key = "f",
				keymap = "<leader>ff",
				key_hl = "DashboardKey",
				key_format = " %s",
				-- Resolve Snacks at activation time so dashboard-nvim can safely cache this command.
				action = "lua require('snacks').picker.files()",
			},
			{
				icon = "󰱼 ",
				icon_hl = "DashboardIcon",
				desc = "Grep",
				desc_hl = "DashboardDesc",
				key = "g",
				keymap = "<leader>fg",
				key_hl = "DashboardKey",
				key_format = " %s",
				action = "lua require('snacks').picker.grep()",
			},
			{
				icon = " ",
				icon_hl = "DashboardIcon",
				desc = "Recent Files",
				desc_hl = "DashboardDesc",
				key = "r",
				keymap = "<leader>fr",
				key_hl = "DashboardKey",
				key_format = " %s",
				action = "lua require('snacks').picker.recent()",
			},
			{
				icon = "󰈙 ",
				icon_hl = "DashboardIcon",
				desc = "Buffers",
				desc_hl = "DashboardDesc",
				key = "b",
				keymap = "<leader>fb",
				key_hl = "DashboardKey",
				key_format = " %s",
				action = "lua require('snacks').picker.buffers()",
			},
			{
				icon = "󰒡 ",
				icon_hl = "DashboardIcon",
				desc = "Diagnostics",
				desc_hl = "DashboardDesc",
				key = "d",
				keymap = "<leader>fd",
				key_hl = "DashboardKey",
				key_format = " %s",
				action = "lua require('snacks').picker.diagnostics()",
			},
		},
		footer = luffy_footer,
		-- Center the complete composition as one balanced block from top to bottom.
		vertical_center = true,
	},
})
