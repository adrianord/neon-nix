{ lib }:

import ./language.nix { inherit lib; } // import ./lua.nix { inherit lib; }
