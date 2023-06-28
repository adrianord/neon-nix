{ config, lib, pkgs, userConf, ... }:

with lib;
let
  cfg = config.neon.programs.zsh;
  FZF_PREVIEW_BIND = "--bind alt-k:preview-up,alt-j:preview-down";
  FZF_LS_PREVIEW = "ls -la --color {}";
  FZF_BAT_PREVIEW = "bat --decorations always --color always {}";
  FZF_BAT_LS_PREVIEW = "if [ -d {} ]; then ${FZF_LS_PREVIEW} ; else ${FZF_BAT_PREVIEW}; fi";
  FZF_CTRL_T_OPTS = "${FZF_PREVIEW_BIND} --preview '${FZF_BAT_LS_PREVIEW}'";
  FZF_DEFAULT_COMMAND = "fd --type d --type f --hidden --follow --exclude .git";
  FZF_ALT_C_COMMAND = "fd --type d --hidden --follow --exclude .git";
in
{
  options = {
    neon.programs.zsh = {
      enable = mkEnableOption "Enable zsh";
    };
  };

  config = mkIf cfg.enable {
    users.users.${userConf.user.name} = mkIf pkgs.stdenv.hostPlatform.isLinux {
      shell = pkgs.zsh;
    };
    environment.shells = with pkgs; [ zsh ];
    programs.zsh.enable = true;

    home._ = {
      home.sessionPath = [
        "$HOME/.local/bin"
      ];
      home.packages = with pkgs; [
        fd
        bat
        nix-zsh-completions
      ];
      home.sessionVariables = {
        FZF_PREVIEW_BIND = FZF_PREVIEW_BIND;
        FZF_LS_PREVIEW = FZF_LS_PREVIEW;
        FZF_BAT_PREVIEW = FZF_BAT_PREVIEW;
        FZF_BAT_LS_PREVIEW = FZF_BAT_LS_PREVIEW;
        FZF_CTRL_T_OPTS = FZF_CTRL_T_OPTS;
        FZF_ALT_C_COMMAND = FZF_ALT_C_COMMAND;
      };
      programs.zsh = {
        enable = true;
        enableSyntaxHighlighting = true;
        enableAutosuggestions = true;
        enableCompletion = true;
        dotDir = ".config/zsh";
        history = {
          extended = true;
          ignorePatterns = [
            "reboot"
          ];
          size = 999999999;
        };
        shellAliases = {
          ls = mkDefault "command ls --color=auto";
          la = mkDefault "command ls --color=auto -lAh";
          cdcode = mkDefault "cd ~/Code";
          g = mkDefault "git";
          rmf = mkDefault "rm -rf";
        };
        completionInit = ''
          autoload -Uz compinit
          compinit -d "''${XDG_CACHE_HOME:-''${HOME}/.cache}/zsh/zcompdump-''${ZSH_VERSION}"
          zmodload zsh/complist
          zstyle ':completion:*' menu select=0 interactive
          setopt menucomplete
        '';

        plugins = [
          {
            name = "fzf-tab";
            src = pkgs.fetchFromGitHub {
              owner = "Aloxaf";
              repo = "fzf-tab";
              rev = "master";
              sha256 = "sha256-GI1+uEpxiMGYiXxfWr1+XtJroFRyX0LhpD7q3zft1E4=";
            };
          }
        ];
        initExtra = ''
          bindkey '^F' fzf-cd-widget
          bindkey '^Y' fzf-file-widget
          bindkey "^[[1;5C" forward-word
          bindkey "^[[1;5D" backward-word
          set +o prompt_cr +o prompt_sp

          nd()
          {
            mkdir -p -- "$1" &&
            cd -P -- "$1"
          }
        '';
      };
      programs.starship = {
        enable = true;
        enableZshIntegration = true;
        settings = {
          add_newline = true;
          gcloud.disabled = true;
        };
      };
      programs.fzf = {
        enable = true;
        enableZshIntegration = true;
        defaultCommand = FZF_DEFAULT_COMMAND;
        defaultOptions = [
          "--height 40%"
          "--reverse"
        ];
      };
    };

  };
}
