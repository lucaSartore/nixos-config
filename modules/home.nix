{ config, ... }: 
{

  imports = [ 
    ./hyprland.home.panels.nix
    ./home.mimeapps.nix
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

  home.file.".bashrc".source = ../assets/.bashrc;

  # copy every element of the "assets/dotconfig" folder inside ~/.config with a system link (for quick editing)
  xdg.configFile = let
    # list of all the dotfiles (or list of dotfiles) that are tracked by nix
    nixDotfiles = builtins.attrNames (builtins.readDir  ../assets/dotconfig);
    # function that given a file name create the configuration
    mkFile = name: {
      name = "${name}";
      value = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/nixos-config/assets/dotconfig/${name}";
        recursive = true;
      };
    };
  in
  builtins.listToAttrs (map mkFile nixDotfiles);



}
