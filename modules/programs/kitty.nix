{ lib, config, pkgs, ... }:

with lib;
let
  cfg = config.neon.programs.kitty;
  catppuccinRepo = fetchGit {
    url = "https://github.com/catppuccin/kitty.git";
    ref = "main";
    rev = "37a9bcac429cdd04c0ecb4041ce6c6e3d4b53f42";
  };
in
{
  options = {
    neon.programs.kitty = with types; {
      enable = mkEnableOption "Kitty";
      font = mkOption {
        description = "Kitty font";
        type = str;
        default = config.neon.common.font.default;
      };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    ({
      home._ = {
        home.file.mocha_kitty = {
          source = "${catppuccinRepo}/mocha.conf";
          target = ".config/kitty/themes/mocha.conf";
        };
        programs.kitty = {
          enable = true;
          font = {
            name = cfg.font;
            size = 13;
          };
          theme = "Catppuccin-Mocha";
          settings = {
            clear_all_shortcuts = "yes";
            scrollback_lines = 10000;
            enable_audio_bell = false;
            update_check_interval = 0;
            macos_titlebar_color = "background";
            macos_quit_when_last_window_closed = "yes";
            placement_strategy = "top-left";
            cursor_blink_interval = 0;
            tab_bar_edge = "top";
            tab_bar_style = "slant";
            disable_ligatures = "always";
          };
        };
      };
    })

    (mkIf pkgs.stdenv.hostPlatform.isDarwin {
      home._.programs.kitty = {
        # Helpful video https://www.youtube.com/watch?v=lHBD6pdJ-Ng
        keybindings =
          {
            "cmd+n" = "new_os_window";
            "cmd+c" = "copy_to_clipboard";
            "cmd+v" = "paste_from_clipboard";
            "cmd+enter" = "send_text all \\x1b\\r"; # Emulate Alt+Enter
          } // mkMerge (genList
            (x:
              let
                code = toString (x + 48);
                num = toString x;
              in
              {
                "cmd+ctrl+${num}" = "send_text all \\x1b[${code};7u"; # Emulate Alt+Ctrl+x
                "cmd+${num}" = "send_text all \\x1b[${code};3u"; # Emulate Alt+x
              }) 10);
      };
    })
  ]);
}
