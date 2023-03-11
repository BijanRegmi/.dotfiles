return {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = {
        ui = {
            check_outdated_servers_on_open = true,
            border = "rounded",
            icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
            },
            keymaps = {
                toggle_server_expand = "<CR>",
                install_server = "i",
                update_server = "u",
                check_server_version = "c",
                update_all_servers = "U",
                check_outdated_servers = "C",
                uninstall_server = "X"
            }
        }
    }
}
