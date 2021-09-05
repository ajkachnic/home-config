# MONADS ARE SCARY
{ config, options, lib, pkgs, ... }:

with lib;

let cfg = config.modules.dev.haskell;
in {
  options.modules.dev.haskell = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs.haskellPackages; [
      brittany # Code formattter
      cabal-install
      ghc
      haskell-language-server
    ];
  };
}
