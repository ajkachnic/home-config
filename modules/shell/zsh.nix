# The Zoomer shell is cool for them prompts.
{ config, options, lib, pkgs, ... }:

with lib;

let cfg = config.modules.shell.zsh;
in {
  options.modules.shell.zsh = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  options.shellAliases = mkOption {
    type = types.attrs;
    default = { };
  };

  # Going to use the home-manager module for zsh since it is cool.
  config = mkIf cfg.enable {
    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    programs.zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autocd = true;
     
      sessionVariables = {
#        VISUAL = "kak";
        EDITOR = "emacs";
#        PAGER = "less";

        NNN_PLUG = "f:fzopen;k:kak_open";
        NNN_FCOLORS = "0404040000000600010F0F02";
      };

      plugins = [
        {
          name = "pure";
          file = "pure.zsh";
          src = pkgs.fetchFromGitHub {
            owner = "sindresorhus";
            repo = "pure";
            rev = "v1.17.2";
            sha256 = "sk7uAYVw/9OLKi3ClBXwEEnfaiprM/gQcNJMDFGqhE0=";
          };
        }
        {
          name = "fzf-tab";
          src = pkgs.fetchFromGitHub {
            owner = "Aloxaf";
            repo = "fzf-tab";
            rev = "89a3315";
            sha256 = "vfF0uEznND3p7eWHLLrnLIw80gVXQ7Zi4Qu+3GgIAL0=";
          };
        }
        {
          name = "fast-syntax-highlighting";
          src = pkgs.fetchFromGitHub {
            owner = "zdharma";
            repo = "fast-syntax-highlighting";
            rev = "v1.55";
            sha256 = "DWVFBoICroKaKgByLmDEo4O+xo6eA8YO792g8t8R7kA=";
          };
        }
        {
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "v0.7.0";
            sha256 = "KLUYpUu4DHRumQZ3w59m9aTW6TBKMCXl2UcKi4uMd7w=";
          };
        }
        {
          name = "forgit";
          src = pkgs.fetchFromGitHub {
            owner = "wfxr";
            repo = "forgit";
            rev = "9f3a4239205b638b8c535220bfec0b1fbca2d620";
            sha256 = "X2tyQtXrKgY5MLAqozqCUlZo+2dgcrY6MP8mSpjPSfA=";
          };
        }
      ];

      shellAliases = {
        open = "xdg-open";
        copy = "xclip -i -selection clipboard";
        rr =
          "curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | sh";

        # Exa aliases
        ls = "exa";
        l = "exa -lbF --git"; # list, size, type, git
        ll = "exa -lbGF --git"; # long list
        llm = "exa -lbGF --git --sort=modified"; # long list, sorted by modified
        la = "exa -lbhHigUmuSa --time-style=long-iso --git --color-scale";
        lt = "exa --tree --level=2";
      };

      initExtra = ''
        export PATH="$HOME/.local/bin:$PATH"
        cdir() {
          mkdir $1 && cd $1
        }

        # File extraction utility
        ex ()
        {
          if [ -f $1 ] ; then
            case $1 in
              *.tar.bz2)   tar xjf $1   ;;
              *.tar.gz)    tar xzf $1   ;;
              *.bz2)       bunzip2 $1   ;;
              *.rar)       unrar x $1   ;;
              *.gz)        gunzip $1    ;;
              *.tar)       tar xf $1    ;;
              *.tbz2)      tar xjf $1   ;;
              *.tgz)       tar xzf $1   ;;
              *.zip)       unzip $1     ;;
              *.Z)         uncompress $1;;
              *.7z)        7z x $1      ;;
              *.deb)       ar x $1      ;;
              *.tar.xz)    tar xf $1    ;;
              *.tar.zst)   unzstd $1    ;;      
              *)           echo "'$1' cannot be extracted via ex()" ;;
            esac
          else
            echo "'$1' is not a valid file"
          fi
        }
      '';

      # syntaxHighlighting.enable = true;
    };
  };
}
