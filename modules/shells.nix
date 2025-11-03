{ config, pkgs, lib, inputs, ... }:

# contains aliases to enable all of my custom shells for one specific use case
{

  programs.bash = {
    shellAliases = {
      cshell-ros-olrc = "nix develop ~/.config/nixos-config/shells/ros-olrc";
      cshell-ros-rp = "nix develop ~/.config/nixos-config/shells/ros-rp";
      cshell-matlab = "nix develop ~/.config/nixos-config/shells/matlab";
      cshell-python-biai = "nix develop ~/.config/nixos-config/shells/python-biai";
    };
  };
}
