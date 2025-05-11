{ inputs, lib, pkgs-stable, ... }:
let
  pkgOverride = [
    { path = "ghostscript"; source = "stable"; }
    { path = "lua-language-server"; source = "stable"; }
    { path = "ansible"; source = "stable"; }
    { path = "awscli2"; source = "stable"; }
    { path = "ruff"; source = "stable"; }
    { path = "etcd"; source = "stable"; }
    { path = "emacs"; source = "stable"; }

    { path = "nodePackages.cdktf-cli"; source = "disable"; }
    { path = "nodePackages_latest.cdktf-cli"; source = "disable"; }
  ];

  splitPackagePath = path:
    let
      parts = builtins.split "\\." path;
    in
    if builtins.length parts == 1
    then { group = null; name = builtins.head parts; }
    else {
      group = builtins.head parts;
      name = builtins.elemAt parts 2;
    };

  mkPackage = config: prev:
    let
      pathList = lib.splitString "." config.path;
    in
    if config.source == "disable" then
      mkDisabledPackage config.path prev
    else if config.source == "stable" then
      lib.getAttrFromPath pathList pkgs-stable
    else
      throw "Unknown source ${config.source} for package ${config.path}";

  mkDisabledPackage = pkgName: prev: prev.stdenv.mkDerivation {
    name = "${pkgName}-disabled";
    version = "0.0.0";

    # Use a minimal build phase
    phases = [ "installPhase" ];

    installPhase = ''
      mkdir -p $out/bin
      
      cat > $out/bin/${pkgName} <<EOF
      #!${prev.bash}/bin/bash
      echo "WARNING: ${pkgName} was disable because it was since it was broken in unstable and stable" >&2
      exit 1
      EOF
      
      # Make the wrapper executable
      chmod +x $out/bin/${pkgName}
    '';

    meta = {
      description = "Disabled package: ${pkgName}";
      priority = 100; # Higher priority to ensure this takes precedence
    };
    __warned = inputs.nixpkgs.lib.warn "Package '${pkgName}' is broken in unstable and stable, so is marked as disabled" null;
  };
in
{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    inputs.firefox-darwin.overlay
    inputs.rust-overlay.overlays.default
    (import ../overlays/vscodeInsiders.nix inputs.vscodeInsiders)
    (import ../overlays/nur.nix inputs.nur)
    (import ../overlays/vscodeExtensions.nix)

    (final: prev:
      let
        # Group packages by their namespace
        grouped = builtins.groupBy
          (pkg:
            let split = splitPackagePath pkg.path;
            in if split.group == null then "root" else split.group
          )
          pkgOverride;

        # Create overlays for packages in a group
        mkGroupOverlay = group: pkgs:
          if group == "root"
          then
            builtins.listToAttrs
              (builtins.map
                (x: {
                  name = x.path;
                  value = mkPackage x prev;
                })
                pkgs)
          else {
            ${group} = prev.${group} // builtins.listToAttrs (builtins.map
              (x: {
                name = (splitPackagePath x.path).name;
                value = mkPackage x prev;
              })
              pkgs);
          };
      in
      builtins.foldl' (acc: group: acc // mkGroupOverlay group grouped.${group}) { } (builtins.attrNames grouped)
    )
  ];
}
