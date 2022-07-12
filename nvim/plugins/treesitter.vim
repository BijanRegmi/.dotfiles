lua << EOF
local treesitter = require('nvim-treesitter.configs')

treesitter.setup {
    sync_install = false,
    highlight = {
        enable = true
    },
    indent = { enable = true }
}

EOF
