{
  user = {
    name = "aordonez";
    email = "adrianord@gmail.com";
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
          "dotnet"
          "go"
          "java"
          "just"
          "latex"
          "lua"
          "markdown"
          "nix"
          "nodejs"
          "python"
          "rust"
          "terraform"
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
          coreutilsRs.enable = true;
          coreutilsRs.zshIntegration = true;
          devbox.enable = true;
          direnv.enable = true;
          discord.enable = true;
          ghostty.enable = true;
          git.enable = true;
          kitty.enable = true;
          kubernetes.enable = true;
          neovim.enable = true;
          pulumi.enable = true;
          signal.enable = true;
          utils.enable = true;
          vivaldi.enable = true;
          zen.enable = true;
          zsh.enable = true;
        };
      };
    })

    {
      homebrew = {
        taps = [
          "grishka/grishka"
        ];
        casks = [
          "zoom"
          "obsidian"
          "nordvpn"
          "slack"
          "cursor"
          "utm"
          "chromium"
          "google-chrome"
          "neardrop"
          "audacity"
          "elmedia-player"
          "balenaetcher"
          "unity-hub"
          "blender"
          "vnc-viewer"
          "folx"
        ];
        brews = [
          "hyperfine"
          "p7zip"
          "ffmpeg"
          "yt-dlp"
          "yamlfmt"
        ];
      };
    }
    ({ pkgs, ... }: {
      home._.home.packages = with pkgs; [
        postgresql
      ];
    })
  ];
}
