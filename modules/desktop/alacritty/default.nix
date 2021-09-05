{ config, options, lib, pkgs, ... }:

with lib;

let cfg = config.modules.desktop.alacritty;
in {
  options.modules.desktop.alacritty = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ alacritty ];

    programs.alacritty = {
      enable = true;
      settings = {
        background_opacity = 0.9;
        font.normal.family = "Space Mono NF";
        font.size = 8;

        colors = (import ./themes/gruvbox.nix).hard;
      };
    };
  };
}
