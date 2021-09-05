# My stuff for C and C++.
{ config, options, lib, pkgs, ... }:

with lib;

let cfg = config.modules.dev.cc;
in {
  options.modules.dev.cc = {
    enable = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      cmake # Yo dawg, I heard you like Make.
      clang # A C compiler frontend for LLVM.
      clang-tools
      lldb
      ccls # Language server
      #      gcc # A compiler toolchain.
      gdb # GNU Debugger.
      tinycc # A tiny c compiler
      llvmPackages.libcxx # When GCC has become too bloated for someone's taste.
    ];
  };
}
