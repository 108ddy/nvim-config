require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'bash', 'c', 'cpp', 'css',
        'dockerfile', 'gitignore', 'html',
        'java', 'javascript', 'json', 'lua',
        'python', 'rust', 'tsx', 'typescript',
    },

    highlight = {
        enable = true,
        additonal_vim_regex_highlighting = false,
    },
}

