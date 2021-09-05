{ config, options, lib, pkgs, ... }:

with lib;

let cfg = config.modules.editors.emacs;
in {
  options.modules.editors.emacs = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [
      (import (builtins.fetchGit {
        url = "https://github.com/nix-community/emacs-overlay.git";
        ref = "master";
        rev = "bfc8f6edcb7bcf3cf24e4a7199b3f6fed96aaecf"; # change the revision
      }))
    ];

    home.packages = with pkgs; [ emacs languagetool ];
  };
}
