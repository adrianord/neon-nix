{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.dotnet;
in
{
  options = lib.neon.mkLanguageOptions config "dotnet";

  config = mkIf cfg.enable (mkMerge [
    ({
      home._ = {
        home.packages = with pkgs; [
          dotnet-sdk
          #omnisharp-roslyn
          jetbrains.rider
        ];

        home = {
          sessionPath = [
            "$HOME/.dotnet/tools"
          ];
        };
      };
    })

    (mkIf pkgs.stdenv.hostPlatform.isDarwin {
      homebrew = {
        casks = [
          "jetbrains-toolbox"
        ];
      };
    })

    (mkIf cfg.neovim.enable {
      neon.programs.neovim.lsp = {
        masonServers = [ "omnisharp" ];
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
