{ inputs, pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    inputs.firefox-darwin.overlay
    inputs.rust-overlay.overlays.default
    (import ../overlays/vscodeInsiders.nix inputs.vscodeInsiders)
    (import ../overlays/nur.nix inputs.nur)
    (import ../overlays/vscodeExtensions.nix)
  ];
}
