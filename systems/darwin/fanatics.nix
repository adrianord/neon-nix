{
  user = {
    name = "adrian.ordonez";
    email = "adrian.ordonez@betfanatics.com";
    fullname = "Adrian Ordonez";
  };
  host = {
    arch = "aarch64";
    os = "darwin";
  };

  modules = [
    ({ lib, ... }: {
      home._.programs.emacs.enable = false;
      neon = {
        common =
          {
            font = {
              size = 14;
            };
          };

        languages = lib.neon.enableLanguages [
          "bash"
          "go"
          "just"
          "lua"
          "markdown"
          "nix"
          "nodejs"
          "python"
          "terraform"
          "tilt"
          "yaml"
        ];
        darwin = {
          utils = {
            enable = true;
            includeUnfree = true;
          };
          configure = true;
        };

        programs = {
          arc.enable = true;
          aws.enable = true;
          kitty.enable = true;
          direnv.enable = true;
          kubernetes.enable = true;
          neovim.enable = true;
          pulumi.enable = true;
          utils.enable = true;
          zsh.enable = true;
          git.enable = true;
          coreutilsRs.enable = true;
          coreutilsRs.zshIntegration = true;
          ansible.enable = true;
          ghostty.enable = true;
        };
      };
    })

    {
      homebrew = {
        taps = [
          {
            name = "fanatics-gaming/homebrew-tap";
            clone_target = "git@github.com:fanatics-gaming/homebrew-tap";
            force_auto_update = true;
          }
          "fluxcd/homebrew-tap"
        ];
        casks = [
          "obsidian"
          "intellij-idea"
          "bitwarden"
          "nordvpn"
          "tableplus"
          "pgadmin4"
          "cursor"
        ];
        brews = [
          "fanatics-gaming/homebrew-tap/fbg-platform-tools"
          "aws-sso-util"
          "fluxcd/tap/flux@0.41"
          "bear"
          "rust"
          "openjdk"
          "poetry"
        ];
      };
    }

    {
      homebrew = {
        brews = [
          "postgresql@16"
        ];
      };
      home._.home.sessionPath = [ "/opt/homebrew/opt/postgresql@16/bin" ];
    }

    {
      homebrew = {
        brews = [
          "ruby"
        ];
      };
      home._.home.sessionPath = [ "/opt/homebrew/opt/ruby/bin" ];
    }
  ];
}
