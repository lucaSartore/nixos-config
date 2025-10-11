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
          # wayclip
          # Add more tools as needed
        ];

        shellHook = ''
          echo "🔧 Setting up your Neovim environment..."

          CONFIG_DIR="$HOME/.config/nvim"
          TERM="xterm-256color"

          # --- Clone Neovim config if missing ---
          if [ ! -d "$CONFIG_DIR" ]; then
            echo "📦 Cloning your Neovim config..."
            git clone https://github.com/lucaSartore/nvim.git "$CONFIG_DIR"

            echo '{"go": false, "nix": false, "python": true, "lua": false, "rust": false, "javascript": true, "csharp": true, "yml": true}' \
              >> "$CONFIG_DIR/language_tools/enabled_languages.json"

          else
            echo "✅ Neovim config already present."
          fi

          echo "🦀 Setting up Rustup for tool building"
          rustup default stable

          echo "✨ Environment ready. Run 'nvim' to start!"

        '';
      };
    };

}
