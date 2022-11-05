if exists("g:neovide")
    let g:neovide_transparency = 0.0
    let g:transparency = 1
    let g:neovide_background_color = '#1e1e2e'.printf('%x', float2nr(255 * g:transparency))
    let g:neovide_cursor_vfx_mode = "wireframe"
    let g:neovide_cursor_vfx_opacity = 100.0
endif

let g:catppuccin_flavour = "mocha" " latte, frappe, macchiato, mocha
lua require("catppuccin").setup()
colorscheme catppuccin