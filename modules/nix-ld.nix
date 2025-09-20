{ config, pkgs, lib, inputs, ... }:

# let
  # temporary until the sql package is fixed
  # mypkgs = import /home/lucas/Desktop/Test/SqlPackage;
# in
{

  # Some times if a package dynamic library is imported from python/js ecc
  # it may ignoring the nix-ld executable and instead rely on the nix-store's one
  # if this is the case it is possible to fix the import by editing the environment variables
  # this shell command helps doing so
  programs.bash = {
    shellAliases = {
      fix-so-import = "export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH";
    };
  };
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs;
    [
      # Add any missing dynamic libraries (.so) for unpackaged programs
      # pkgs.libmysqlclient # dependency of mariadb's python package
      # pkgs.libmysqlclient.dev

      # temporary fix until my commit is accepted
      # mypkgs.sql
      # mypkgs.sql.dev
    ];
}
