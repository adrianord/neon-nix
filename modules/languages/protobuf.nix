{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.protobuf;
in
{
  options = lib.neon.language.mkOptions "protobuf";

  config = mkIf cfg.enable {

    neon.programs.neovim.lsp = mkIf cfg.neovim.enable {
      servers = [ "bufls" ];
      tsLanguages = [ "proto" ];
    };

    home._ = {
      home.packages = with pkgs; [
        protobuf
        grpcurl
        buf
        buf-language-server
      ];

      programs.vscode = mkIf cfg.vscode.enable {
        extensions = with pkgs.vscode-extensions; [
          zxh404.vscode-proto3
        ];
      };
    };
  };
}
