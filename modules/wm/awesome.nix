# Me first, you second, I 3!
{ config, options, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.wm.i3;
  mod = "Mod4";
  term = "alacritty";
in {
  options.modules.wm.i3 = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      i3-gaps
      i3lock
      feh
      brightnessctl
      #  i3status
      # rofi
      networkmanagerapplet
      xss-lock
    ];

    services.polybar =
      let colors = (import ../desktop/kitty/themes/gruvbox.nix).hard;
      in {
        enable = true;
        package = pkgs.polybar.override {
          i3GapsSupport = true;
          githubSupport = true;
        };

        script = "polybar main &";

        settings = {
          "bar/main" = {
            width = "100%";
            height = 32;
            top = true;

            background = colors.background;
            foreground = colors.foreground;

            modules-left = "i3";
            modules-center = "date time";
            modules-right = "memory ip-wlan battery";

            tray-position = "right";
            tray-padding = 1;

            font = [
              "Iosevka Term:pixelsize=12;1"
              "unifont:fontfomrat=trutype:size=8:antialias=false;0"
              "FontAwesome:pixelsize=12;1"
              "FontAwesome5Free:style=Solid:size=12;1"
              "FontAwesome5Free:style=Regular:size=12;1"
              "FontAwesome5Brands:style=Regular:size=12;1"
            ];
          };
          "module/i3" = {
            type = "internal/i3";
            format-foreground = colors.foreground;
            format = "<label-state> <label-mode>";

            #            label-mode-foreground = colors.color0;
            #            label-mode-background = colors.color4;

            # Active workspace on focused monitor
            label-focused = "%name%";
            label-focused-background = "#fe8019";
            label-focused-foreground = colors.background;
            label-focused-padding = 1;

            # Inactive workspace on any monitor
            label-unfocused = "%name%";
            label-unfocused-background = colors.color0;
            label-unfocused-padding = 1;

            index-sort = true;
          };

          "module/date" = {
            type = "internal/date";
            interval = 5;
            date = "%B-%d";
            format-prefix = "  ";
            label = "%date%";
          };
          "module/time" = {
            type = "internal/date";
            interval = 1;
            date = "%I:%M";
            format-prefix = " ";
            label = "%time%";
          };
          "module/memory" = {
            type = "internal/memory";
            interval = 3;
            label = "  %gb_free% ";
          };
          "module/ip-wlan" = {
            type = "internal/network";
            interface = "wlp2s0";
            label-connected = "%downspeed:9% ";
          };
          "module/battery" = {
            type = "internal/battery";
            battery = "BAT1";
            adapter = "AC";
            full-at = 95;
            poll-interval = 1;
            time-format = "%H:%M";
          };
        };
      };

    services.dunst = { enable = true; };
    services.picom = { enable = true; };

    xsession.windowManager.i3 = {
      enable = true;
      config = {
        floating.modifier = mod;
        modifier = mod;

        bars = [ ]; # Disable i3status

        gaps = {
          inner = 16;
          outer = 4;
          smartGaps = true;
        };

        startup = [
          {
            command = "nm-applet &";
            notification = false;
          }
          {
            command = "xss-lock --transfer-sleep-lock -- i3lock --nofork";
            notification = false;
          }
          { command = "polybar main &"; }
          {
            command = "feh --bg-fill ~/Pictures/Wallpapers/wall_secondary.png";
          }
          { command = "brightnessctl set 50%"; }
        ];

        terminal = term;

        fonts = {
          names = [ "monospace" ];
          size = 8.0;
        };

        keybindings = lib.mkOptionDefault {
          "${mod}+Return" = "exec ${term}";
          "${mod}+Shift+Return" = "exec rofi -show drun";
          "${mod}+Shift+q" = "kill";
          "${mod}+Shift+e" = ''
            exec "i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3?' -b 'Yes, exit i3' 'i3-msg-exit' '';

          "${mod}+Shift+h" = "move left";
          "${mod}+Shift+j" = "move down";
          "${mod}+Shift+k" = "move up";
          "${mod}+Shift+l" = "move right";

          "${mod}+h" = "focus left";
          "${mod}+j" = "focus down";
          "${mod}+k" = "focus up";
          "${mod}+l" = "focus right";
        };
      };
    };
  };
}
