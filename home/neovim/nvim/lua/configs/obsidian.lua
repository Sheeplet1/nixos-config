local options = {
  workspaces = {
    {
      name = "personal",
      path = "~/Documents/personal/vaults/my-second-brain",
    },
  },
  notes_subdir = "notes",
  new_notes_location = "notes_subdir",
  templates = {
    folder = "templates",
  },
  attachments = {
    img_folder = "attachments",
  },
}
require("obsidian").setup(options)
