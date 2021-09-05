# Node.js stuff
{ config, options, lib, pkgs, ... }:

with lib;

let cfg = config.modules.dev.node;
in {
  options.modules.dev.node = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nodejs
      yarn # Better package manager
      nodePackages.pnpm # Even better node package manager
      nodePackages.prettier # Code formatter
      nodePackages.eslint # Code linter
      nodePackages.node2nix
    ];
  };
}
