{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.java;
in
{
  options = lib.neon.mkLanguageOptions config "java";

  config = mkIf cfg.enable (mkMerge [
    ({
      home._ = {
        home.packages = with pkgs; [
          jdk
          maven
          gradle
          spring-boot-cli
        ];
      };
    })

    (mkIf cfg.neovim.enable {
      neon.programs.neovim.lsp = mkIf cfg.neovim.enable { };
    })

    (mkIf cfg.vscode.enable { })


    (mkIf cfg.zsh.enable { })
  ]);
}
