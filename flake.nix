{
  description = "Gvarph's neovim config as as a nix plugin";

  inputs = {
    copilotchat = {
      flake = false;
      url = "github:CopilotC-Nvim/CopilotChat.nvim?ref=canary";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs @ {
    self,
    flake-parts,
    nixpkgs,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      flake = {
        lib = import ./lib {inherit inputs;};
      };

      systems = ["aarch64-darwin" "aarch64-linux" "x86_64-darwin" "x86_64-linux"];

      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        ...
      }: let
        inherit (pkgs) alejandra just mkShell;
      in {
        apps = {
          nvim = {
            program = "${config.packages.neovim}/bin/nvim";
            type = "app";
          };
        };

        devShells = {
          default = mkShell {
            buildInputs = [just];
          };
        };

        formatter = alejandra;

        packages = {
          default = self.lib.mkVimPlugin {inherit system;};
          neovim = self.lib.mkNeovim {inherit system;};
        };
      };
    };
}
