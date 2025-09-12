{ config, pkgs, lib, inputs, ... }:

# contains aliases to enable all of my custom shells for one specific use case
{

  programs.bash = {
    enable = true;
    shellAliases = {
      cshell-ros-olrc = "nix develop ~/nixos-config/shells/ros-olrc";
    };
  };
}
