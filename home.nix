{ config, pkgs, ... }:

let
  defaultPkgs = with pkgs; [
    arandr # XRandr GUI
    brave # Browser of choice
    discord # Discord
    nushell # Fancy interactive shell
    # rofi # Better dmenu
    slack # Slacking off at work
    spotify # Music
    xclip # Clipboard manager

    pass
    passExtensions.pass-otp
    tree-sitter

    bitwarden-cli

    bspwm
    sxhkd

    hugo
    okular
  ];

  xmonadPkgs = with pkgs; [
    networkmanagerapplet # networkmanager applet
    nitrogen # wallpaper manager
    xcape # keymaps modifier
  ];
in {
  imports = [ ./modules ];
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home = {
    username = "andrew";
    homeDirectory = "/home/andrew";
    stateVersion = "21.05";

    packages = defaultPkgs ++ xmonadPkgs;
  };

  modules.browser.firefox.enable = true;

  modules.desktop.alacritty.enable = true;
  modules.desktop.audio = {
    enable = true;
    composition.enable = true;
  };
  modules.desktop.kitty.enable = true;
  modules.desktop.rofi.enable = true;

  modules.dev.base.enable = true;
  modules.dev.cc.enable = true;
  modules.dev.elm.enable = true;
  modules.dev.git.enable = true;
  modules.dev.go.enable = true;

  modules.dev.lua.enable = true;
  modules.dev.node.enable = true;
  modules.dev.python.enable = true;
  modules.dev.rust.enable = true;
  modules.dev.zig.enable = true;

  modules.editors.emacs.enable = true;
  modules.editors.kakoune.enable = true;
  modules.editors.neovim.enable = true;
  modules.editors.vscode.enable = true;

  modules.shell.base.enable = true;
  modules.shell.zsh.enable = true;

  modules.wm.i3.enable = true;
}
