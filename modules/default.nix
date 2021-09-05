{ config, options, lib, pkgs, ... }:

with lib; {
  imports = [ ./browser ./desktop ./dev ./editors ./shell ./wm ];
}
