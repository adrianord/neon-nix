{ config, lib, ... }:

with lib;
let
  cfg = config.neon.programs.neovim;
  quotedServers = builtins.map (x: "\"${x}\"") cfg.lsp.servers;
  concattedServers = builtins.concatStringsSep ", " quotedServers;

  quotedTs = builtins.map (x: "\"${x}\"") cfg.lsp.tsLanguages;
  concattedTs = builtins.concatStringsSep ", " quotedTs;
in
{
  options = {
    neon.programs.neovim.lsp = with types; {
      servers = mkOption {
        description = "List of servers to enable that are no managed by mason";
        type = listOf str;
        default = [];
      };
      tsLanguages = mkOption {
        description = "List of treesitter languages to ensure";
        type = listOf str;
        default = [];
      };
    };
  };

  config = mkIf cfg.enable {
    home._.xdg.configFile = {
      astroNvimUserLspServer = {
        text = ''
          return { ${concattedServers} }
        '';
        target = "nvim/lua/user/lsp/servers.lua";
      };
      astroNvimUserTreesitter = {
        text = ''
          return {
            ensure_installed = { ${concattedTs} }
          }
        '';
        target = "nvim/lua/user/plugins/treesitter.lua";
      };
    };
  };
}
