{ config, lib, neon-lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.nix;
in
{
  options = neon-lib.language.mkOptions "dotnet";

  config = mkIf cfg.enable {
    home._ = {
      home.packages = with pkgs; [
        dotnet-sdk
        jetbrains.rider
      ];
      home.sessionPath = [
        "$HOME/.dotnet/tools"
      ];
      programs.zsh = mkIf cfg.enableZshIntegration {
        initExtra = ''
          _dotnet_zsh_complete()
          {
            #compdef dotnet
            local completions=("$(dotnet complete "$words")")
            [[ -n "$completions" ]] && compadd -- "''${(ps:\n:)completions}"
          }

          compdef _dotnet_zsh_complete dotnet
        '';
      };
      programs.vscode = mkIf cfg.enableVscodeIntegration {
        extensions = with pkgs.vscode-extensions; [
          ms-dotnettools.csharp
        ];
      };
    };
  };
}
