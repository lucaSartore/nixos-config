# to run: nix develop github:lucaSartore/nixos-config?dir=shells/nvim-quindi --refresh
{
  description = "Portable Neovim environment";

  inputs = { nixpkgs.url = "github:NixOS/nixpkgs"; };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.${system}.default = pkgs.mkShell {
        name = "portable-neovim-env";

        nativeBuildInputs = with pkgs; [
          neovim
          git
          lazygit
          ripgrep
          rustup
          ripgrep
          lazygit
          gcc
          luajitPackages.luarocks_bootstrap
          go
          python314
          unzip
          omnisharp-roslyn
          # wayclip
          # Add more tools as needed

        ];

        shellHook = ''
          echo "🔧 Setting up your Neovim environment..."

          
          CONFIG_DIR="$HOME/.config/nvim-luca-sartore"
          TERM="xterm-256color"

          # necessary to enable the osc52 clipboard
          VIM_SSH_CONNECTION="true"

          # --- Clone Neovim config if missing ---
          if [ ! -d "$CONFIG_DIR" ]; then
            echo "📦 Cloning your Neovim config..."
            git clone https://github.com/lucaSartore/nvim.git "$CONFIG_DIR"

            echo '{"go": false, "nix": false, "python": true, "lua": false, "rust": false, "javascript": true, "csharp": true, "yml": true}' \
              >> "$CONFIG_DIR/lua/language_tools/enabled_languages.json"

            # rustup is necessary for many of the tools built in neovim
            echo "🦀 Setting up Rustup for tool building"
            rustup default stable
          else
            echo "✅ Neovim config already present."
          fi


          alias nvim="nvim -u $CONFIG_DIR/init.lua"

          echo "✨ Environment ready. Run 'nvim' to start!"

        '';
      };
    };

}
