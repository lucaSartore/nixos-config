{ config, pkgs, inputs, lib, ... }: {

  imports = [ 
    # ./plasma_manager.nix
    ./hyprland.home.nix
  ];

  home.username = "lucas";
  home.homeDirectory = "/home/lucas";
  # The home.stateVersion option does not have a default and must be set
  home.stateVersion = "25.11";

  # git config
  programs.git = {
    enable = true;
    settings = {
      user.name = "Luca Sartore";
      user.email = "lucasartore02@gmail.com";
      credential.helper = "manager";
      credential."https://github.com".username = "lucaSartore";
      credential.credentialStore = "cache";
      safe.directory = "/etc/nixos"; 
      pull.rebase = false;
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


  home.file.".omnisharp/omnisharp.json".source = ../assets/omnisharp.json;

  home.file.bashrc = {
    target = ".bashrc";
    text = ''
      eval "$(atuin init bash --disable-up-arrow)"
    '';
  };

  home.file.".ideavimrc".source = ../assets/.ideavimrc;
  
  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixos-config/assets/submodules/nvim";
    recursive = true;
  };


  xdg.configFile."ghostty/config".source = ../assets/ghostty/config;

  xdg.configFile."kanata/kanata.kbd".source = ../assets/submodules/kanata_config/kanata.kbd;

}
