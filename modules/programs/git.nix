{ config, lib, pkgs, userConf, ... }:

with lib;
let
  cfg = config.neon.programs.git;

  gitAliasOpts = { config, ... }: with types; {
    options = {
      folder = {
        type = str;
        description = "Folder within ~/Code to apply alias";
      };
      email = mkOption {
        type = str;
        description = "Git email address";
      };
      initBranch = mkOption {
        type = str;
        description = "Default init branch";
        default = "main";
      };
    };

    config = {
      home._.programs.git.includes = [
        {
          condition = "gitdir:~/Code/${config.folder}/";
          contents = {
            user = {
              email = config.email;
            };
            init = {
              defaultBranch = config.initBranch;
            };
          };
        }
      ];
    };
  };
in
{
  options = {
    neon.programs.git = with types; {
      enable = mkEnableOption "Enable git support";
      aliases = mkOption {
        type = listOf (submodule gitAliasOpts);
        description = "Map of work git aliases";
      };
    };
  };

  config = mkIf cfg.enable {
    home._ = {
      home.packages = with pkgs; [
        gh
        act
        gitoxide
      ];
      programs.git = {
        enable = true;
        lfs.enable = true;
        userName = userConf.user.fullname;
        userEmail = userConf.user.email;
        aliases = {
          a = "add";
          b = "branch";
          c = "commit";
          d = "diff";
          l = "log";
          m = "merge";
          r = "rebase";
          s = "status";
          co = "checkout";
          dt = "difftool";
          ps = "push";
          psf = "push --force-with-lease";
          pl = "pull";
          lol = "log --oneline";
          amend = "commit --no-edit --amend";
          cl = "clone";
          pushf = "push --force-with-lease";
          cloneb = "clone --no-checkout --config core.bare=true";
          wt = "worktree";
          wtl = "worktree list";
          wta = "worktree add";
          wtr = "worktree remove";
          wtp = "worktree prune";
          wtc = "worktree add $1 $1";
        };
        extraConfig = {
          pull = {
            rebase = true;
          };
          push = {
            autoSetupRemote = true;
          };
          init = {
            defaultBranch = "main";
          };
        };
        delta = {
          enable = true;
          options = {
            features = "side-by-side line-numbers decorations";
            whitespace-error-style = "22 reverse";
            syntax-theme = "Monokai Extended";
            navigation = true;
            plus-style = "syntax #012800";
            minus-style = "syntax #340001";
            decorations = {
              commit-decoration-style = "bold yellow box ul";
              file-style = "bold yellow ul";
              file-decoration-style = "none";
            };
          };
        };
      };
    };
  };
}
