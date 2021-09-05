# Like haskell, but front-end
{ config, options, lib, pkgs, ... }:

with lib;

let cfg = config.modules.dev.elm;
in {
  options.modules.dev.elm = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      elmPackages.elm
      elmPackages.elm-format
      elmPackages.elm-live
      elmPackages.elm-review
      elmPackages.elm-test
    ];
  };
}
