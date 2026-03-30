# a few reminders
#
# NEW INSTALLATION
# every time you install the system to a new PC you'll need to generate a new age key starting
# from your SSH key
# `mkdir -p ~/.config/sops/age/ && ssh-to-age -private-key -i ~/.ssh/id_ed25519 > ~/.config/sops/age/keys.txt`
#
# EDIT SECRETS
# `cd ~/.config/nixos-config/assets/secrets && sops secrets.yaml`
#
# KEY CHANGE
# if you need to change the key, you'll first need to 
# - save the unencrypted secrets somewhere
# - generate the new public key (see above)
# - re-generate a public key with `age-keygen -y ~/.config/sops/age/keys.txt`
# - copy the public key in `assets/secrets/.sops.yaml`
# - re-edit secrets.yaml using `sops secrets.yaml`

{ pkgs, inputs, ... }:
{
  imports =
    [
      inputs.sops-nix.nixosModules.sops
    ];

  environment.systemPackages = [
    # necessary to generate the key the first time
    pkgs.ssh-to-age
    pkgs.age
    # necessary every time you need to edit the  secrets
    pkgs.sops
  ];

  sops.defaultSopsFile = ../assets/secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/home/user/.config/sops/age/keys.txt";
  sops.secrets.nas_password = { };
}
