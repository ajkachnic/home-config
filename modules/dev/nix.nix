{ config, options, lib, pkgs, ... }:

with lib;

let cfg = config.modules.dev.nix;
in {
  options.modules.dev.nix = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      nixfmt # Formatter
      rnix-lsp # Language server
    ];
  };
}
