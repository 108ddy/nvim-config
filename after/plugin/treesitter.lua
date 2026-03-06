require('nvim-treesitter.configs').setup {
    ensure_installed = {
        'asm', 'bash', 'c', 'cmake', 'cpp', 'css',
        'desktop', 'dockerfile', 'gitignore', 'graphql',
        'html', 'htmldjango', 'http', 'java', 'javascript', 'json',
        'lua', 'markdown', 'markdown_inline', 'python', 'query',
        'rust', 'scss', 'sql', 'tmux', 'tsx', 'typescript', 'vim',
        'vue', 'xml', 'yaml', 'zig',
    },

    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },

    incremental_selection = {
        enable = true,
    },

    indent = {
        enable = true,
    },
}

