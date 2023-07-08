{ config, lib, ... }:

with lib;
let
  cfg = config.neon.programs.neovim;
  quotedServers = builtins.map (x: "\"${x}\"") cfg.lsp.servers;
  concattedServers = builtins.concatStringsSep ", " quotedServers;

  quotedTs = builtins.map (x: "\"${x}\"") cfg.lsp.tsLanguages;
  concattedTs = builtins.concatStringsSep ", " quotedTs;
  quotedMasonServers = builtins.map (x: "\"${x}\"") cfg.lsp.masonServers;
  concattedMasonServers = builtins.concatStringsSep ", " quotedMasonServers;

  serverSettingsOpts = with types; { };
in
{
  options = {
    neon.programs.neovim.lsp = with types; {
      servers = mkOption {
        description = "List of servers to enable that are no managed by mason";
        type = listOf str;
        default = [ ];
      };
      tsLanguages = mkOption {
        description = "List of treesitter languages to ensure";
        type = listOf str;
        default = [ ];
      };
      serverSettings = mkOption {
        description = "Server settings for LSP";
        type = attrsOf attrs;
        default = { };
      };
      masonServers = mkOption {
        description = "List of servers to enable that are managed by mason";
        type = listOf str;
        default = [ ];
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
            "nvim-treesitter/nvim-treesitter",
            opts = {
              ensure_installed = { ${concattedTs} }
            }
          }
        '';
        target = "nvim/lua/user/plugins/treesitter.lua";
      };
      astroNvimUserMasonLspConfig = {
        text = ''
          return {
              "williamboman/mason-lspconfig.nvim",
              opts = {
                ensure_installed = { ${concattedMasonServers} }
              }
            }
        '';
        target = "nvim/lua/user/plugins/mason-lspconfig.lua";
      };
    } // concatMapAttrs
      (name: value: {
        "astroNvimUser${name}ServerSettings" = {
          text = ''
            return ${lib.neon.toLuaObject value}; 
          '';
          target = "nvim/lua/user/lsp/config/${name}.lua";
        };
      })
      cfg.lsp.serverSettings;
  };
}
