return {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
        ui = {
            border = "rounded",
        },
        ensure_installed = {}
    }
}
