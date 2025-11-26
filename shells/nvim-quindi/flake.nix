# to run: nix develop github:lucaSartore/nixos-config?dir=shells/nvim-quindi --refresh

# to fix the issues related to ghostty
# infocmp -x xterm-ghostty | ssh YOUR-SERVER -- tic -x -
# full ref: https://ghostty.org/docs/help/terminfo
# the error:
#  > older tic versions may treat the description field as an alias
# can be ignored
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
          csharpier
          # wayclip
          # Add more tools as needed

        ];

        shellHook = ''
          echo "🔧 Setting up your Neovim environment..."

          # using a special name so that I can avoid overriding local environments
          export NVIM_APPNAME="nvim-luca-sartore"
          CONFIG_DIR="$HOME/.config/$NVIM_APPNAME"

          # fix for the ghostty terminal over SSH
          # not usefull if you run the command above (copy
          # export TERM="xterm-256color"

          # necessary to enable the osc52 clipboard (to copy and paste over ssh)
          export NVIM_ENABLE_OSC52="true"

          # --- Clone Neovim config if missing ---
          if [ ! -d "$CONFIG_DIR" ]; then
            echo "📦 Cloning your Neovim config..."
            git clone https://github.com/lucaSartore/nvim.git "$CONFIG_DIR"

            echo '{
              "go": false,
              "nix": false,
              "python": true,
              "lua": false,
              "rust": false,
              "javascript": true,
              "csharp": true,
              "yml": true,
              "cpp": false
            }' >> "$CONFIG_DIR/lua/language_tools/enabled_languages.json"

            # rustup is necessary for many of the tools built in neovim
            echo "🦀 Setting up Rustup for tool building"
            rustup default stable
          else
            echo "✅ Neovim config already present... Updating it"
            (cd $CONFIG_DIR; git pull)
          fi


          echo "✨ Environment ready. Run 'nvim' to start!"

        '';
      };
    };

}
