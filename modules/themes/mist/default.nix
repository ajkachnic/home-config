{ config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.theme;
in {
  config = mkIf (cfg.active == "mist") {
    services.picom = {
      enable = true;
    };
    services.windowManager.bspwm = {
      enable = true;
    };
  };
}
