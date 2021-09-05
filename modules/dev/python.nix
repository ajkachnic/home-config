# hisssss
{ config, options, lib, pkgs, ... }:

with lib;

let cfg = config.modules.dev.python;
in {
  options.modules.dev.python = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      python39
      python39Packages.pip
      python39Packages.ipython
      python39Packages.black # Code formatter
      python39Packages.setuptools
      python39Packages.pylint # Linter
      python39Packages.poetry # Better package manager
    ];

    shellAliases = {
      py = "python";
      py2 = "python2";
      py3 = "python3";
      po = "poetry";
    };
  };
}
