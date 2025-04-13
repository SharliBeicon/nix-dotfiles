{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nix-darwin,
    home-manager,
    ...
  }: let
    makeHomeManagerConfiguration = {
      system,
      username,
      homeDirectory ? "/Users/${username}",
    }: let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./modules/home.nix
          {
            home = {
              inherit homeDirectory username;
              stateVersion = "24.11";
            };
          }
        ];
        extraSpecialArgs = { inherit inputs; };
      };
  in {
    formatter.aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.alejandra;
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
    homeConfigurations.carlostocinocubelo = makeHomeManagerConfiguration {
      system = "aarch64-darwin";
      username = "carlostocinocubelo";
    };
  };
}
