{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.nodejs;
  npm_prefix = "$HOME/.npm/node_modules";
  typescriptFormatter = "vscode.typescript-language-features";
  jsonFormatter = "vscode.json-language-features";
in
{
  options = lib.neon.mkLanguageOptions config "nodejs";

  config = mkIf cfg.enable (mkMerge [
    ({
      # Implicitly enable JSON
      neon.languages.json = {
        enable = true;
        vscode.enable = cfg.vscode.enable;
        neovim.enable = cfg.neovim.enable;
        zsh.enable = cfg.zsh.enable;
      };


      home._ = {
        home.sessionVariables = {
          NPM_CONFIG_PREFIX = npm_prefix;
        };
        home.sessionPath = [
          "${npm_prefix}/bin"
        ];
        home.packages = with pkgs;
          [
            nodejs
            jq
            yarn
            bun
          ] ++ (with pkgs.nodePackages; [
            js-beautify
            pnpm
            typescript-language-server
            typescript
            zx
            vscode-langservers-extracted
            svelte-language-server
          ]);
      };
    })

    (mkIf cfg.neovim.enable {
      neon.programs.neovim.lsp = mkIf cfg.neovim.enable {
        servers = [
          "ts_ls"
          "cssls"
          "html"
          "svelte"
        ];
        masonServers = [
          "eslint-lsp"
          "tailwindcss-language-server"
          "emmet-language-server"
          "astro-language-server"
        ];
        tsLanguages = [
          "javascript"
          "typescript"
          "html"
          "css"
          "svelte"
          "astro"
        ];
      };
    })

    (mkIf cfg.vscode.enable {
      home._.programs.vscode = {
        extensions = with pkgs.vscode-extensions;[
          dbaeumer.vscode-eslint
          bradlc.vscode-tailwindcss
          prisma.prisma
        ];
        userSettings = {
          eslint = {
            validate = [ "typescript" ];
            format.enable = true;
          };
          prettier = {
            proseWrap = "always";
          };
          "[typescript]" = {
            "editor.defaultFormatter" = typescriptFormatter;
            "editor.formatOnPaste" = false;
            "editor.formatOnType" = false;
            "editor.formatOnSave" = true;
            "files.autoSave" = "onFocusChange";
          };
          "[typescriptreact]" = {
            "editor.defaultFormatter" = typescriptFormatter;
          };
          "[json]" = {
            "editor.defaultFormatter" = jsonFormatter;
          };
          "[jsonc]" = {
            "editor.defaultFormatter" = jsonFormatter;
          };
        };
      };
    })

    (mkIf cfg.zsh.enable {
      home._.programs.zsh = {
        initContent = ''
          ###-begin-pnpm-completion-###
          if type compdef &>/dev/null; then
            _pnpm_completion () {
              local reply
              local si=$IFS
  
              IFS=$'\n' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" pnpm completion -- "$\{words[@]}"))
              IFS=$si
  
              if [ "$reply" = "__tabtab_complete_files__" ]; then
                _files
              else
                _describe 'values' reply
              fi
            }
            compdef _pnpm_completion pnpm
          fi
          ###-end-pnpm-completion-###
        '';
      };
    })
  ]);
}
