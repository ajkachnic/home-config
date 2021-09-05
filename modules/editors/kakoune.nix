# Vim, but not
{ config, options, lib, pkgs, ... }:

with lib;

let cfg = config.modules.editors.kakoune;
in {
  options.modules.editors.kakoune = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.kakoune = {
      enable = true;
      plugins = with pkgs.kakounePlugins; [
        kak-fzf # Fuzzy finding
        kak-lsp # Language server client
        parinfer-rust # turn lisp into python
        kak-auto-pairs # Auto pair parens
      ];

      config = {
        hooks = [
          {
            name = "WinSetOption";
            option = "filetype=javascript";
            commands =
              "set-option buffer formatcmd 'prettier --stdin-file foo.js'";
          }
          {
            name = "WinSetOption";
            option = "filetype=typescript";
            commands =
              "set-option buffer formatcmd 'prettier --stdin-file foo.ts'";
          }
          {
            name = "WinSetOption";
            option = "filetype=nix";
            commands = "set-option buffer formatcmd 'nixfmt'";
          }
          {
            name = "WinCreate";
            option = "[^*]*";
            commands = "editorconfig-load";
          }
        ];
        keyMappings = [
          {
            key = "<space>";
            mode = "normal";
            effect = ",";
          }
          {
            key = "<space>";
            mode = "user";
            effect = ":require-module fzf-file; fzf-file<ret>";
            docstring = "Use fzf to find files";
          }
          {
            key = "f";
            mode = "user";
            effect = ":fzf-mode<ret>";
            docstring = "Open fzf mode";
          }
        ];
        colorScheme = "gruvbox";
        numberLines = {
          relative = true;
          enable = true;
        };
        showWhitespace = {
          enable = true;
          lineFeed = " ";
          tab = "|";
        };
        # tapStop = 2;
        wrapLines = { enable = true; };
      };
    };

    #    pkgs.nnn.override.withNerdIcons = true;
    #    pkgs.nnn.withNerdIcons = true;

    home.packages = with pkgs; [ nnn ];
  };
}
