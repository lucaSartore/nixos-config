{ config, pkgs, lib, inputs, pkgs-unstable, ... }:
{
  environment.systemPackages = [
    # the neovim program
    pkgs.neovim
    # general dependency for various plugins/lsp
    pkgs.rustup
    pkgs.ripgrep
    pkgs.lazygit
    pkgs.gcc
    pkgs.luajitPackages.luarocks_bootstrap
    pkgs.go
    pkgs.nodejs_24
    (pkgs.python3.withPackages (ps: [ 
      ps.numpy
      ps.debugpy
      ps.matplotlib
      ps.pandas
      ps.scipy
    ]))
    pkgs.unzip
    pkgs.wayclip
    # pkgs.dotnetCorePackages.sdk_9_0-bin
    # pkgs.dotnetCorePackages.sdk_8_0-bin
    pkgs.dotnet-sdk_9
    pkgs.omnisharp-roslyn
    
    pkgs-unstable.csharpier
    pkgs.tree-sitter
  ];

  # alias
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
  };

}
