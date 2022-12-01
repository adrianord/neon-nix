{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.dotnet;
in
{
  options = lib.neon.language.mkOptions "dotnet";

  config = mkIf cfg.enable {
    home._ = {
      home.packages = with pkgs; [
        dotnet-sdk_7
        jetbrains.rider
      ];
      home.sessionPath = [
        "$HOME/.dotnet/tools"
      ];
      programs.zsh = mkIf cfg.zsh.enable {
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
      programs.vscode = mkIf cfg.vscode.enable {
        extensions = with pkgs.vscode-extensions; [
          ms-dotnettools.csharp
        ];
      };
    };
  };
}
