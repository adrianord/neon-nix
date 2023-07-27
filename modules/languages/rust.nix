{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.rust;
in
{
  options = lib.neon.mkLanguageOptions config "rust";

  config = mkIf cfg.enable (mkMerge [
    ({
      # Implicitly enable TOML
      neon.languages.toml = {
        enable = true;
        vscode.enable = cfg.vscode.enable;
        neovim.enable = cfg.neovim.enable;
        zsh.enable = cfg.zsh.enable;
      };

      home._ = {
        home.packages = with pkgs; [
          rust-analyzer
          trunk
          cargo-edit
          cargo-watch
          bacon
          wasm-pack
          wasm-bindgen-cli
          (rust-bin.nightly.latest.default.override {
            extensions = [ "rust-src" ];
            targets = [
              "aarch64-apple-darwin"
              "wasm32-unknown-unknown"
              "x86_64-apple-darwin"
              "x86_64-unknown-linux-gnu"
            ];
          })
        ];
      };
    })

    (mkIf cfg.neovim.enable {
      neon.programs.neovim.lsp = mkIf cfg.neovim.enable {
        servers = [ "rust_analyzer" ];
        tsLanguages = [ "rust" ];
      };
    })

    (mkIf cfg.vscode.enable {
      home._.programs.vscode = {
        extensions = with pkgs.vscode-extensions; [
          rust-lang.rust-analyzer
          serayuzgur.crates
        ];

        userSettings = {
          rust-analyzer = {
            checkOnSave = {
              command = "clippy";
            };
            inlayHints = {
              parameterHints.enable = false;
              typeHints.enable = false;
              chainingHints.enable = false;
              closingBraceHints.enable = false;
            };
            cargo = {
              buildScripts = {
                enable = true;
              };
            };
          };
        };
      };
    })

    (mkIf cfg.zsh.enable { })
  ]);
}
