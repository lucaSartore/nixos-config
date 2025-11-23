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
        name = "MSFT0001:00 04F3:3140 Touchpad";
        naturalScroll = true;
        pointerSpeed = 0;
        productId = "3140";
        tapToClick = true;
        vendorId = "04f3";
      }];
    };
  };
}
