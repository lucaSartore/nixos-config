{ config, pkgs, lib, ... }:

{
  imports = [ ../../modules/home.nix ];

  programs.plasma = {

    # laptop specific touchpads input
    # list inputs: cat /proc/bus/input/devices
    input = {
      touchpads = [{
        disableWhileTyping = true;
        enable = true;
        leftHanded = true;
        middleButtonEmulation = true;
        name = "ELAN06FA:00 04F3:327E Touchpad";
        naturalScroll = true;
        pointerSpeed = 0;
        productId = "327e";
        tapToClick = true;
        vendorId = "04f3";
      }];
    };
  };
}
