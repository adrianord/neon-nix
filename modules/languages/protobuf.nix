{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.neon.languages.protobuf;
in
{
  options = lib.neon.language.mkOptions "protobuf";

  config = mkIf cfg.enable {

    home._ = {
      home.packages = with pkgs; [
        protobuf
        grpcurl
      ];

      programs.vscode = mkIf cfg.vscode.enable {
        extensions = with pkgs.vscode-extensions; [
          zxh404.vscode-proto3
        ];
      };
    };
  };
}
