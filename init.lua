vim.opt.runtimepath:prepend((os.getenv("HOME") or os.getenv("HOMEPATH")) .. "/dot")

require "nvim_config"
