{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.dotnet;
in
{
  options = lib.neon.language.mkOptions config "dotnet";

  config = mkIf cfg.enable (mkMerge [
    ({
      home._ = {
        home.packages = with pkgs; [
          dotnet-sdk_7
          omnisharp-roslyn
        ];

        home.sessionPath = [
          "$HOME/.dotnet/tools"
        ];
      };
    })

    (mkIf cfg.neovim.enable {
      neon.programs.neovim.lsp = {
        servers = [ "omnisharp" ];
        tsLanguages = [ "c_sharp" ];
      };
    })

    (mkIf cfg.vscode.enable {
      home._.programs.vscode = {
        extensions = with pkgs.vscode-extensions; [
          ms-dotnettools.csharp
        ];
      };
    })

    (mkIf cfg.zsh.enable {
      home._.programs.zsh = mkIf cfg.zsh.enable {
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
    })
  ]);
}
