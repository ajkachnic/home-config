{ config, options, lib, pkgs, ... }:

with lib; {
  imports = [ ./firefox ];
}
