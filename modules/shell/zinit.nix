{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.programs.zsh.zinit;

  pluginModule = types.submodule ({ config, ... }: {
    options = {
      name = mkOption {
        type = types.str;
        description = "The name of the plugin.";
      };
      ices = mkOption {
        type = types.listOf types.str;
        description = "The ices to use for a plugin";
        default = [ ];
      };
      light = mkOption {
        type = types.bool;
        description = "Disable load-time tracking (minimal performance impact)";
        default = false;
      };
    };

  });

  loadPlugin = plugin: (''
    ${
      if plugin.ices != [ ] then
        "zinit ice ${concatStringsSep " " plugin.ices}"
      else
        ""
    }  
    zinit ${if plugin.light then "light" else "load"} ${plugin.name}'');

in {
  options.programs.zsh.zinit = {
    enable = mkEnableOption "zinit - a zsh plugin manager";

    # prompt = pluginModule;

    plugins = mkOption {
      default = [ ];
      type = types.listOf pluginModule;
      description = "List of zinit plugins.";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ pkgs.zinit ];

    programs.zsh.initExtraBeforeCompInit = ''
      source ${pkgs.zinit}/share/zinit/zinit.zsh

      ${concatStringsSep "\n" (map loadPlugin cfg.plugins)}
    '';

  };
}

