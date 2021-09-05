{ config, options, lib, pkgs, ... }:

with lib;

let cfg = config.modules.desktop.kitty;
in {
  options.modules.desktop.kitty = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ kitty ];

    programs.kitty = {
      enable = true;
      font.size = 13;
      font.name = "Iosevka NF";
      settings = (import ./themes/gruvbox.nix).hard;
    };
  };
}
