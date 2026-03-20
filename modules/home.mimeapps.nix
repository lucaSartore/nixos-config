{ config, pkgs, inputs, lib, ... }: 
let
  imgviewer = "imv.desktop";
in
{

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      ##### Browser defaults ####
      "text/html" = "google-chrome.desktop";
      "x-scheme-handler/http" = "google-chrome.desktop";
      "x-scheme-handler/https" = "google-chrome.desktop";
      "x-scheme-handler/about" = "google-chrome.desktop";
      "x-scheme-handler/unknown" = "google-chrome.desktop";
      "inode/directory" = "pcmanfm.desktop";       # File Manager
      "application/pdf" = "org.pwmt.zathura.desktop"; # PDF Reader

      "image/png" = imgviewer;                 # Image Viewer
      "image/jpeg" = imgviewer;
      "video/mp4" = "mpv.desktop";                 # Video Player
      "text/plain" = "nvim.desktop";               # Text Editor
    };
  };

}
