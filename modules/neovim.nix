{ config, pkgs, lib, inputs, pkgs-unstable, ... }:

let
  cloneScript = pkgs.writeShellScript "setup-nvim-repo" ''
    set -eux
    if [ ! -d /home/lucas/.config/nvim ]; then
      ${pkgs.git}/bin/git clone https://github.com/lucaSartore/nvim /home/lucas/.config/nvim
      cd /home/lucas/.config/nvim
      ${pkgs.git}/bin/git remote set-url origin git@github.com:lucaSartore/nvim.git
    fi
  '';
in {

  systemd.services.cloneNvimConfigs = {
    description = "Clone nvim config into .config folder";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      User = "lucas";
      ExecStart = "${cloneScript}";
    };
  };

  environment.systemPackages = with pkgs; [
    # the neovim program
    pkgs.neovim
    # general dependency for various plugins/lsp
    pkgs.rustup
    pkgs.ripgrep
    pkgs.lazygit
    pkgs.gcc
    pkgs.luajitPackages.luarocks_bootstrap
    pkgs.go
    pkgs.nodejs_24
    (pkgs.python3.withPackages (ps: [ 
      ps.numpy
      ps.matplotlib
    ]))
    pkgs.unzip
    pkgs.wayclip
    # pkgs.dotnetCorePackages.sdk_9_0-bin
    # pkgs.dotnetCorePackages.sdk_8_0-bin
    pkgs.dotnet-sdk_9
    pkgs.omnisharp-roslyn
    
    pkgs-unstable.csharpier
    pkgs.tree-sitter
  ];

  # alias
  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
  };

}
