local status, git = pcall(require, 'git')
if (not status) then return end

git.setup({
	keymaps = {
		-- Opens blame window
		blame = "<leader>gb",
		-- Opens file / folder in git repo
		browse = "<leader>go",
	}
})
