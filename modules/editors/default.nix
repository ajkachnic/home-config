# All of my text editors (and IDEs) modules are to be put here.
# From Visual Studio Code, Emacs, Neovim, and whatnot.
# The entryway to all of your text editors and IDEs.
{ config, options, lib, pkgs, ... }:

with lib; {
  imports = [ ./emacs.nix ./kakoune.nix ./neovim.nix ./vscode.nix ];
}
