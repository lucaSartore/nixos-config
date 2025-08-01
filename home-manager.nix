{ config, pkgs, ... }:

let
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-25.05.tar.gz;
in
{
  imports = [
    (import "${home-manager}/nixos")
  ];


  home-manager.users.lucas = {
    /* The home.stateVersion option does not have a default and must be set */
    home.stateVersion = "25.05";

    # git config
    programs.git = {
        enable = true;
        userName  = "Luca Sartore";
        userEmail = "lucasartore02@gmail.com";

        extraConfig = {
          safe.directory = "/etc/nixos";
        };
    };

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        ##### Browser defaults ####
        "text/html" = "google-chrome.desktop";
        "x-scheme-handler/http" = "google-chrome.desktop";
        "x-scheme-handler/https" = "google-chrome.desktop";
        "x-scheme-handler/about" = "google-chrome.desktop";
        "x-scheme-handler/unknown" = "google-chrome.desktop";
      };
    };
  };
}
