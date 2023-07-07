{ ... }:
{
  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
    settings = {
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      interval = { Weekday = 0; Hour = 0; Minute = 0; };
      options = "--delete-older-than 30d";
    };
  };
}
