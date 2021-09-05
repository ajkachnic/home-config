{ config, options, lib, pkgs, ... }:

with lib; {
  imports = [ ./audio.nix ./alacritty ./kitty ./rofi.nix ];
}
