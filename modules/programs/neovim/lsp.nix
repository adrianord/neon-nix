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

  concattedLspConfigs = builtins.concatStringsSep ", " (mapAttrsToList
    (name: value: ''
      ${name} = ${lib.neon.toLuaObject value}
    '')
    cfg.lsp.serverSettings);

  nvimDir = "${config.home.config.xdg.configHome}/nvim";
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
    home._.home.file = {
      "${nvimDir}/lua/plugins/astrolsp-extended.lua".text = ''
        return {
          "AstroNvim/astrolsp",
          opts = {
            servers = { ${concattedServers} },
            config = { ${concattedLspConfigs} },
          },
        }
      '';

      "${nvimDir}/lua/plugins/treesitter-extended.lua".text = ''
        return {
          "nvim-treesitter/nvim-treesitter",
          opts = {
            ensure_installed = { ${concattedTs} }
          }
        }
      '';

      "${nvimDir}/lua/plugins/mason-tool-installer-extended.lua".text = ''
        return {
          "WhoIsSethDaniel/mason-tool-installer.nvim",
          opts = {
            ensure_installed = { ${concattedMasonServers} }
          }
        }
      '';
    };

    home._.xdg.configFile = {
      astroNvimUserLspServer = {
        text = ''
          return { ${concattedServers} }
        '';
        target = "old_nvim/lua/user/lsp/servers.lua";
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
        target = "old_nvim/lua/user/plugins/treesitter.lua";
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
        target = "old_nvim/lua/user/plugins/mason-lspconfig.lua";
      };
    } // concatMapAttrs
      (name: value: {
        "astroNvimUser${name}ServerSettings" = {
          text = ''
            return ${lib.neon.toLuaObject value}; 
          '';
          target = "old_nvim/lua/user/lsp/config/${name}.lua";
        };
      })
      cfg.lsp.serverSettings;
  };
}
