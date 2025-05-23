{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    nix-homebrew,
    homebrew-core,
    homebrew-cask,
    fenix,
    ...
  }: {
    packages.aarch64-darwin.default = fenix.packages.aarch64-darwin.stable.toolchain;
    darwinConfigurations."charliebacon" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        home-manager.darwinModules.home-manager
        nix-homebrew.darwinModules.nix-homebrew
        ({pkgs, ...}: {
          nixpkgs = {
            config.allowUnfree = true;
            overlays = [fenix.overlays.default];
          };
          environment.systemPackages = with pkgs; [
            fenix.packages.${system}.stable.completeToolchain
          ];
        })
        {
          nix-homebrew = {
            enable = true;
            user = "charliebacon";
            taps = {
              "homebrew/homebrew-core" = homebrew-core;
              "homebrew/homebrew-cask" = homebrew-cask;
            };
            mutableTaps = false;
          };
        }
        {
          home-manager.extraSpecialArgs = {
            inherit inputs;
          };
        }
        ./hosts/charliebacon/default.nix
      ];
    };
  };
}
