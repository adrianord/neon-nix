{ config, lib, ... }:

with lib;
let
  cfg = config.neon.programs.zellij;
  plugins = {
    choose-tree = "https://github.com/laperlej/zellij-choose-tree/releases/latest/download/zellij-choose-tree.wasm";
  };
in
{
  options = {
    neon.programs.zellij = {
      enable = mkEnableOption "zellij";
      zsh = {
        enable = mkEnableOption "${name} zsh integration" // {
          default = config.neon.programs.zsh.enable;
        };
      };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    ({
      home._ = {
        programs.zellij = {
          enable = true;
          enableZshIntegration = config.neon.programs.zsh.enable;
        };
        xdg.configFile = {
          zellijLayout = {
            source = ../../files/zellij;
            target = "zellij";
          };
        };
      };
    })

    (mkIf cfg.zsh.enable {
      home._.programs.zsh = mkIf cfg.zsh.enable {
        initExtraBeforeCompInit = ''
          if [[ -n $ZELLIJ ]]; then
            (set +m; zellij action rename-tab "" &)
          fi
        '';
      };
    })


  ]);

}
