{ pkgs, ... }: {
  # necesary services to recognize USB
  services.udisks2.enable = true;
  services.gvfs.enable = true;
  services.udev.packages = [ pkgs.libmtp ];
  security.polkit.enable = true;

  # packages
  environment.systemPackages = with pkgs; [
    kdePackages.kio-extras
    kdePackages.kio
    udiskie 
    kdePackages.polkit-kde-agent-1
    libmtp 
  ];
}
