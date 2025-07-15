-- Disable builtin plugins to speed up a startup
vim.g.loaded_netrw = 1
vim.loaded_netrwPlugin = 1

-- Plugins
-- Путь к lazy.nvim
vim.opt.rtp:prepend("~/.local/share/nvim/lazy/lazy.nvim")

require("lazy").setup({
    -- Статус-строка
    { "nvim-lualine/lualine.nvim" },
    -- Подсветка синтаксиса (через treesitter)
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate"
    },
    -- Комментирование
    { "numToStr/Comment.nvim", config = true },
    -- Цветовая схема
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 }
})

-- Инициализация плагинов
require("lualine").setup()
require("nvim-treesitter.configs").setup {
  highlight = { enable = true },
}

-- Базовые настройки
vim.opt.number = true         -- номера строк
vim.opt.relativenumber = true -- относительные номера
vim.opt.expandtab = true      -- заменять табы на пробелы
vim.opt.shiftwidth = 4        -- размер отступа
vim.opt.tabstop = 4
vim.opt.smartindent = true    -- автоотступ
vim.opt.wrap = false          -- отключить перенос строк
vim.opt.scrolloff = 8         -- отступ сверху/снизу при прокрутке

-- Поиск
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Буфер
vim.opt.hidden = true         -- переключение между буферами без сохранения

-- Копирование
vim.opt.clipboard = "unnamedplus" -- использовать системный буфер обмена

-- Цвета
vim.opt.termguicolors = true
vim.cmd.colorscheme "catppuccin"

-- => Hotkeys
-- Быстрый выход из insert mode
vim.keymap.set("i", "jk", "<Esc>")

