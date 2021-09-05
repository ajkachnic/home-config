{ config, options, lib, pkgs, ... }:

with lib; {
  imports = [ ./base.nix ./zsh.nix ./zinit.nix ./starship.nix ];
}
