local ok, dap = pcall(require, "dap")
if not ok then return end

local yes, dapui = pcall(require, "dapui")
if not yes then return end

dapui.setup({})
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
