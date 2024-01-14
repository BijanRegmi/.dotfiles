return {
    theme = "dragon",
    undercurl = true,
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    typeStyle = {},
    variablebuiltinStyle = { italic = true },
    -- special highlight for the return keyword
    specialReturn = true,
    -- special highlight for exception handling keywords
    specialException = true,
    -- do not set background color
    transparent = false,
    -- dim inactive window `:h hl-NormalNC`
    dimInactive = false,
    -- adjust window separators highlight for laststatus=3
    globalStatus = false,
    -- define vim.g.terminal_color_{0,17}
    terminalColors = true,
    -- map the value of 'background' option to a theme
    background = {
        dark = "dragon",
        light = "lotus",
    },
}
