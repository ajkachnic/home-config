# Here are the base packages for my shell workflow.
{ config, options, lib, pkgs, ... }:

with lib;

let cfg = config.modules.shell.base;
in {
  options.modules.shell.base = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      aspell # Hunt down a spelling bee champion to come to your shell.
      bat # cat(1) with wings.
      buku # A developer-oriented browser-independent bookmark manager.
      exa # ls(1) after an exodus.
      fd # find(1) after a cognitive behavioral therapy.
      fzf # A fuzzy finder that enables fuzzy finding not furry finding, a common misconception.
      gopass # The improved version of Password Store which is a password manager for hipsters.
      gotop # A sysadmin's best friend that just happens to be a dashboard.
      graphviz # The biz central for graphical flowcharts.
      hexyl # Binary viewer with a cool name on the command-line.
      # hledger # Do your accountancy thing ON THE COMMAND LINE, sure why not!
      httpie # Want a piece of the humble pie to humbly HTTP requests?
      jq # A command-line interface for parsing JSON.
      killall # Murderous fun
      lazygit # For the lazy gits who cannot get good at Git.
      lazydocker # For the lazy gits who cannot get good at Docker.
      lolcat
      maim # A command-line interface for parsing screenshots.
      ncdu # Better du
      neofetch # Information is power
      pup # A command-line interface for parsing HTML.
      (ripgrep.override { withPCRE2 = true; }) # Super-fast full-text searcher.
      shellcheck # Check your shell if it's broken.
      sqlite # Battle-tested cute little database that can grow into an abomination of a data spaghetti.
      tree # I'm not a scammer, I swear.
      unzip # Unzip what? The world may never know.
      # youtube-dl # A program that can be sued for false advertisement as you can download from other video sources.
      zoxide # Navigate the filesystem at the speed of sound.
    ];

    programs = {
      bat = {
        enable = true;
        config = { theme = "base16"; };
      };
      fzf = {
        enable = true;
        defaultCommand = "fd --type f";
      };

      zoxide.enable = true;
    };
  };
}
