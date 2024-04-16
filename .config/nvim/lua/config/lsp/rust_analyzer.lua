return {
    inlayHints = { locationLinks = false },
    diagnostics = {
        enable = true,
        experimental = {
            enable = true,
        },
    },
    procMacro = {
        ignored = {
            leptos_macro = {
                "component",
                "server",
            },
        },
    },
}
