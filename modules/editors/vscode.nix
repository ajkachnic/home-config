# Visual Studio but for codes...
# The code is really stolen from the NixOS wiki at https://nixos.wiki/wiki/Vscode.
{ config, options, lib, pkgs, ... }:

with lib;

let
  extensions = (with pkgs.vscode-extensions; [
    bbenoist.Nix # Nix support
    esbenp.prettier-vscode # Format web dev code
    matklad.rust-analyer # Rust language server
    elmtooling.elm-ls-vscode # Elm language server
    dbaeumer.vscode-eslint # ESLINT
    file-icons.file-icons # Better file icons
    ms-vscode.cpptools # Tools for CPP
    xaver.clang-format # Format with `clang-format`
    vscodevim.vim # VIM for vscode
    golang.Go # Go language support
    editorconfig.editorconfig
  ]) ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [ ];
in {
  options.modules.editors.vscode = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf config.modules.editors.vscode.enable {
    programs.vscode = { enable = true; };
  };
}
