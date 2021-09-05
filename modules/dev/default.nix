{ config, options, lib, pkgs, ... }:

with lib; {
  imports = [
    ./base.nix
    ./cc.nix
    ./elm.nix
    ./git.nix
    ./go.nix
    ./lua.nix
    ./node.nix
    ./python.nix
    ./rust.nix
    ./zig.nix
  ];
}
