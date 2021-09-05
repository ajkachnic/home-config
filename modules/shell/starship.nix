# Here are the base packages for my shell workflow.
{ config, options, lib, pkgs, ... }:

with lib;

let cfg = config.modules.shell.starship;
in {
  options.modules.shell.starship = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.starship = {
      enable = true;
      settings = {
        python.disabled = true;
        nodejs.disabled = true;
        rust.disabled = true;
        golang.disabled = true;
        vlang.disabled = true;
        lua.disabled = true;
        git_branch.symbol = "";
      };
      enableZshIntegration = config.modules.shell.zsh.enable;
    };
  };
}
