{ lib, config, ... }:

with lib;
let
  cfg = config.neon.programs.alacritty;
  catppuccinRepo = fetchGit {
    url = "https://github.com/catppuccin/alacritty.git";
    ref = "main";
    rev = "3c808cbb4f9c87be43ba5241bc57373c793d2f17";
  };
in
{
  options = {
    neon.programs.alacritty = with types; {
      enable = mkEnableOption "Alacritty";
      font = mkOption {
        description = "Alacritty font";
        type = str;
        default = config.neon.common.font.default;
      };
    };
  };

  config = mkIf cfg.enable {
    home._.programs.alacritty = {
      enable = true;
      settings = {
        import = [
          "${catppuccinRepo}/catppuccin-mocha.yml"
        ];
        font = {
          size = config.neon.common.font.size;
          normal = {
            family = cfg.font;
          };
          bold = {
            family = cfg.font;
          };
          italic = {
            family = cfg.font;
          };
          bold_italic = {
            family = cfg.font;
          };
        };
      };
    };
  };
}
