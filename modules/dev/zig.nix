# Better C
{ config, options, lib, pkgs, ... }:

with lib;

let cfg = config.modules.dev.zig;
in {
  options.modules.dev.zig = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable { home.packages = with pkgs; [ zig zls ]; };
}
