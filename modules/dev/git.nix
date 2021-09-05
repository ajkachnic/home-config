{ config, options, lib, pkgs, ... }:

with lib;

let
  cfg = config.modules.dev.git;
  gitConfig = {
    init.defaultBranch = "main";
    core = {
      editor = "nvim";
      pager = "bat";
    };
    pull.rebase = false;
  };
in {
  options.modules.dev.git = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      gh # GitHub CLI
      diff-so-fancy # Better git diff
    ];
    programs.git = {
      enable = true;
      userName = "Andrew Kachnic";
      userEmail = "ajkachnic@protonmail.com";
      extraConfig = gitConfig;
      aliases = {
        br = "branch";
        cm = "commit -m";
        get = "!npx git-yoink";
        st = "status";
      };
    };
  };
}
