{ config, pkgs, lib, inputs, ... }:

# contains aliases to enable all of my custom shells for one specific use case
{

  programs.bash = {
    shellAliases = {
      cshell-ros-olrc = "nix develop ~/.config/nixos-config/shells/ros-olrc";
    };
  };
}
