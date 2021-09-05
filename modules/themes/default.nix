{ options, config, lib, pkgs, ... }:

with lib;
let cfg = config.modules.theme;
in
{
  options.modules.theme = {
    active = mkOption {
      type = types.nullOr types.str;
      default = null;
    };
  };
}
