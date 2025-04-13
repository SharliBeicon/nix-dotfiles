{ config, pkgs, ... }:

{
  system.stateVersion = 6;

  users.users.carlostocinocubelo = {
    name = "carlostocinocubelo";
    home = "/Users/carlostocinocubelo";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.carlostocinocubelo = import ./home.nix;
  };

  system.defaults = {
    dock.autohide = true;
  };

  nixpkgs.config.allowUnfree = true;
}
