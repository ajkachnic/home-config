{
  allowUnfree = true;
  packageOverrides = pkgs: {
    nnn = pkgs.nnn.override { withNerdIcons = true; };
    nur = import (builtins.fetchTarball
      "https://github.com/nix-community/NUR/archive/master.tar.gz") {
        inherit pkgs;
      };
  };
}
