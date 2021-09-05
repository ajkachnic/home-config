{ config, options, lib, pkgs, ... }:

with lib;

let cfg = config.modules.desktop.rofi;
in {
  options.modules.desktop.rofi = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      font = "Iosevka NF 10";
      package = pkgs.rofi.override { plugins = [ pkgs.rofi-emoji ]; };
      extraConfig = { modi = "drun,emoji"; };
      theme = let inherit (config.lib.formats.rasi) mkLiteral;
      in {
        "*" = {
          background-color = mkLiteral "#282828";
          border-color = mkLiteral "#282828";
          text-color = mkLiteral "#ebdbb2";
          # height = mkLiteral "20px";
        };

        "#window" = {
          anchor = mkLiteral "north";
          location = mkLiteral "north";
          width = mkLiteral "100%";
          children = map mkLiteral [ "horibox" ];
        };
        "#horibox" = {
          orientation = mkLiteral "horizontal";
          children = map mkLiteral [ "inputbar" "listview" ];
        };
        "#inputbar" = {
          padding = mkLiteral "2px";
          expand = false;
          width = mkLiteral "10em";
        };
        "#listview" = {
          layout = mkLiteral "horizontal";
          padding = 0;
          columns = 1;
          fixed-height = false;
          spacing = 0;
          # lines = 100;
        };
        "#entry" = { background-color = "#282828"; };
        "#element" = {
          padding = mkLiteral "2px 8px";
          background-color = mkLiteral "#3c3836";
          text-color = mkLiteral "#d5c4a1";
        };
        "#element selected" = {
          background-color = mkLiteral "#8ec07c";
          text-color = mkLiteral "#3c3836";
        };
      };
    };
  };
}
