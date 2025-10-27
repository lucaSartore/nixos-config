{ config, pkgs, inputs, lib, ... }: {

  imports = [ 
    ./plasma_manager.nix
  ];

  home.username = "lucas";
  home.homeDirectory = "/home/lucas";
  # The home.stateVersion option does not have a default and must be set
  home.stateVersion = "25.05";

  # git config
  programs.git = {
    enable = true;
    userName = "Luca Sartore";
    userEmail = "lucasartore02@gmail.com";
    extraConfig = { 
      credential.helper = "manager";
      credential."https://github.com".username = "lucaSartore";
      credential.credentialStore = "cache";
      safe.directory = "/etc/nixos"; 
      pull.rebase = true;
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

  home.file.".rustup/settings.toml".text = ''
    default_toolchain = "stable-x86_64-unknown-linux-gnu"
    profile = "default"
    version = "12"

    [overrides]
  '';

  home.file.".config/google-chrome/NativeMessagingHosts/org.kde.plasma.browser_integration.json" =
    {
      source =
        "${pkgs.kdePackages.plasma-browser-integration}/etc/chromium/native-messaging-hosts/org.kde.plasma.browser_integration.json";
    };

  xdg.configFile."hypr/hyprland.conf".source = ../assets/hyprland/hyprland.conf;
  xdg.configFile."rofi/config.rasi".source = ../assets/hyprland/config.rasi;
  xdg.configFile."rofi/themes" = {
    source = ../assets/submodules/rofi_themes_collection;
    recursive = true;
  };
  xdg.configFile."ghostty/config".source = ../assets/ghostty/config;
}
