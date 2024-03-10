local Cheezaram_Fugitive = vim.api.nvim_create_augroup("Cheezaram_Fugitive", {})

local autocmd = vim.api.nvim_create_autocmd
autocmd("BufWinEnter", {
  group = Cheezaram_Fugitive,
  pattern = "*",
  callback = function()
    if vim.bo.ft ~= "fugitive" then
      return
    end

    local bufnr = vim.api.nvim_get_current_buf()
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "<leader>gp", function()
      -- vim.cmd.Git { "push", "--force" }
      vim.cmd.Git { "push --force" }
    end, opts)

    -- rebase always
    vim.keymap.set("n", "<leader>P", function()
      -- vim.cmd.Git { "pull", "--rebase" }
      vim.cmd.Git { "pull --rebase" }
    end, opts)

    -- NOTE: It allows me to easily set the branch i am pushing and any tracking
    -- needed if i did not set the branch up correctly
    vim.keymap.set("n", "<leader>t", ":Git push -u origin ", opts)
  end,
})
