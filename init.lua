-- Bootstrap lazy.nvim if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin setup
require("lazy").setup({
{
  "NLKNguyen/papercolor-theme",
  lazy = false,
  priority = 1000,
},
  -- LSP configuration
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("lspconfig").pyright.setup({})
    end,
  },

  -- Mason for managing external tools
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }),
      })
    end,
  },

  -- Telescope for fuzzy finding
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          file_ignore_patterns = { "node_modules", ".git/" },
        },
      })
      -- Map Ctrl+P to Telescope find_files
      vim.keymap.set("n", "<C-p>", require("telescope.builtin").find_files, { noremap = true, silent = true })
    end,
  },
})

-- General settings
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.number = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- Enable Pyright
-- npm install -g pyright
vim.lsp.enable('pyright')


-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300


-- Core behavior and editing
vim.opt.compatible = false           -- disable Vi compatibility
vim.opt.hidden = true               -- allow buffers in background without saving
vim.opt.encoding = "utf-8"          -- set internal Vim encoding
vim.opt.fileencoding = "utf-8"      -- set file writing encoding
vim.opt.clipboard = "unnamedplus"   -- use system clipboard
vim.opt.mouse = "a"                -- enable mouse support in all modes:contentReference[oaicite:3]{index=3}
vim.opt.title = true               -- set the terminal title
vim.opt.autoread = true            -- auto-reload files changed outside Vim

-- Indentation and tabs
vim.opt.expandtab = true            -- convert tabs to spaces
vim.opt.shiftwidth = 4              -- indent size for < and >
vim.opt.tabstop = 4                 -- number of spaces that a <Tab> counts for
vim.opt.softtabstop = 4             -- spaces per Tab in insert mode
vim.opt.autoindent = true           -- copy indent from previous line
vim.opt.smartindent = true          -- extra indenting for C-like programs

-- Line numbers
vim.opt.number = true               -- show absolute line numbers
-- vim.opt.relativenumber = true       -- show relative line numbers
vim.opt.cursorline = true           -- highlight the current line


-- Appearance
vim.opt.termguicolors = true        -- enable 24-bit RGB colors
vim.opt.colorcolumn = "120"         -- highlight column 80 as a guide
vim.opt.showmatch = true           -- briefly jump to matching bracket
vim.opt.list = true                -- show whitespace characters
vim.opt.listchars = { space = '_', tab = '>~', trail = '·', nbsp = '+' }
vim.opt.signcolumn = 'yes'
                                    -- define symbols for space/tab (see example:contentReference[oaicite:5]{index=5})

-- Scrolling and redraw
vim.opt.scrolloff = 3              -- keep 3 lines visible when scrolling
vim.opt.sidescrolloff = 5          -- same for horizontal scroll
vim.opt.lazyredraw = true          -- do not redraw while executing macros

-- Leader key
vim.g.mapleader = ' '               -- map <Space> as <Leader> (set before mappings):contentReference[oaicite:7]{index=7}




-- Buffer navigation
vim.keymap.set('n', '<Leader>bn', '<cmd>bnext<CR>',    { desc = "Next buffer" })
vim.keymap.set('n', '<Leader>bp', '<cmd>bprevious<CR>',{ desc = "Previous buffer" })
vim.keymap.set('n', '<Leader>bd', '<cmd>bdelete<CR>',  { desc = "Delete buffer" })
vim.keymap.set("n", "<S-Tab>", "<C-^>", { noremap = true, silent = true })


-- Toggle spell checking
vim.keymap.set('n', '<F6>', '<cmd>set spell! spell?<CR>',
                { desc = "Toggle spelling" })

-- Toggle paste mode
vim.keymap.set('n', '<F2>', '<cmd>set invpaste paste?<CR>',
                { desc = "Toggle paste mode" })

-- Copy/paste with system clipboard
vim.keymap.set({'n','v'}, '<Leader>y', '"+y', { desc = "Yank to clipboard" })
vim.keymap.set({'n','v'}, '<Leader>p', '"+p', { desc = "Paste from clipboard" })

-- Move lines up/down (Alt + j/k)
vim.keymap.set('n', '<M-j>', ':m .+1<CR>==',    { desc = "Move line down" })
vim.keymap.set('n', '<M-k>', ':m .-2<CR>==',    { desc = "Move line up" })
vim.keymap.set('v', '<M-j>', ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set('v', '<M-k>', ":m '<-2<CR>gv=gv", { desc = "Move selection up" })


-- Backup and swap files
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false

-- Persistent undo
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath('state')..'/undo'  -- use XDG state directory:contentReference[oaicite:11]{index=11}

-- Ignore patterns (files/folders to skip completion/search)
vim.opt.wildignore = { '*.o', '*.obj', '*~', '*/node_modules/*', '*/.git/*' }

-- Enable automatic reading of file if changed
vim.opt.autoread = true

vim.opt.hlsearch = true            -- highlight search matches:contentReference[oaicite:14]{index=14}
vim.opt.incsearch = true           -- incremental search

vim.opt.ignorecase = true          -- ignore case in searches:contentReference[oaicite:15]{index=15}
vim.opt.smartcase = true           -- but *override* if uppercase letter is used:contentReference[oaicite:16]{index=16}


-- Restore cursor to last edit position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local line = mark[1]
    if line > 0 and line <= vim.api.nvim_buf_line_count(0) then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

-- Strip trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = "%s/\\s\\+$//e",  -- see usage on Vim documentation:contentReference[oaicite:20]{index=20}
})


-- Folding
vim.opt.foldmethod = "indent"      -- fold based on indentation
vim.opt.foldcolumn = "1"          -- show a fold-column (width 1):contentReference[oaicite:22]{index=22}
vim.opt.foldlevel = 99             -- open most folds by default
vim.opt.foldenable = false         -- disable folding by default


-- Enable syntax highlighting
vim.cmd('syntax on')

-- Enable filetype detection and plugins
vim.cmd('filetype plugin indent on')

vim.opt.langmap = {
  "ΑA", "ΒB", "ΨC", "ΔD", "ΕE", "ΦF", "ΓG", "ΗH", "ΙI", "ΞJ",
  "ΚK", "ΛL", "ΜM", "ΝN", "ΟO", "ΠP", "ΡR", "ΣS", "ΤT", "ΘU",
  "ΩV", "ΧX", "ΥY", "ΖZ",
  "αa", "βb", "ψc", "δd", "εe", "φf", "γg", "ηh", "ιi", "ξj",
  "κk", "λl", "μm", "νn", "οo", "πp", "ρr", "σs", "τt", "θu",
  "ωv", "ςw", "χx", "υy", "ζz"
}

vim.cmd.colorscheme("PaperColor")
