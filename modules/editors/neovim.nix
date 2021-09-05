# (Neo)Vim is love, (Neo)Vim is life.
{ config, options, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.editors.neovim;

  # installs a vim plugin from git with a given tag / branch
  pluginGit = ref: repo:
    vimUtils.buildVimPluginFrom2Nix {
      pname = "${lib.strings.sanitizeDerivationName repo}";
      version = ref;
      src = builtins.fetchGit {
        url = "https://github.com/${repo}.git";
        ref = ref;
      };
    };

  # always installs latest version
  plugin = pluginGit "HEAD";
in {
  options.modules.editors.neovim = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    # Add the nightly overlay
    nixpkgs.overlays = [
      (import (builtins.fetchTarball {
        url =
          "https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz";
      }))
    ];

    # programs.neovim = {
    # enable = true;
    # package = pkgs.neovim-nightly;
    # };

    home.packages = with pkgs; [
      neovim-nightly
      neovide # A very cool neovim desktop client
      editorconfig-core-c # Editorconfig is a MUST, you feel me?!
    ];
  };
}
