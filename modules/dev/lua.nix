{ config, options, lib, pkgs, ... }:

with lib;

let cfg = config.modules.dev.lua;
in {
  options.modules.dev.lua = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      luajit
      sumneko-lua-language-server
      luaformatter
    ];
  };
}
