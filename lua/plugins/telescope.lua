return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make", },
    },

    -- TODO: check where I can define variable to rid of long length
    --[[keys = {
        { "<leader>ff", require("telescope.builtin").find_files, desc="Telescope find files" },
        { "<leader>fg", require("telescope.builtin").live_grep, desc="Telescope live grep" },
        { "<leader>fb", require("telescope.builtin").buffers, desc="Telescope buffers" },
        { "<leader>fh", require("telescope.builtin").help_tags, desc="Telescope help tags" },
    },]]--
    config = function()
        require("telescope").setup({
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
                color_devicons = true,
                layout_config = {
                    prompt_position = "bottom",
                    horizontal = {
                        width_padding = 0.04,
                        height_padding = 0.1,
                        preview_width = 0.6,
                    },
                    vertical = {
                        width_padding = 0.05,
                        height_padding = 1,
                        preview_height = 0.5,
                    },
                },
                prompt_prefix = "❯ ",
                selection_caret = "❯ ",
                sorting_strategy = "ascending",
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--hidden",
                },
                dynamic_preview_title = true,
                winblend = 4,
            },
        })
        require("telescope").load_extension("fzf")

        -- Use this if you will not find a solution to the problem above
        local builtin = require("telescope.builtin")

        vim.keymap.set('n', "<leader>ff", builtin.find_files, {})
        vim.keymap.set('n', "<leader>fg", builtin.live_grep, {})
        vim.keymap.set('n', "<leader>fb", builtin.buffers, {})
        vim.keymap.set('n', "<leader>fh", builtin.help_tags, {})
    end,
}

