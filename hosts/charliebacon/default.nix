{ config, pkgs, ... }:

{
  system.stateVersion = 6;

  users.users.charliebacon = {
    name = "charliebacon";
    home = "/Users/charliebacon";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.charliebacon = import ./home.nix;
  };

  system.defaults = {
    dock = {
      autohide = true;
      show-recents = false;
    };
    finder = {
      AppleShowAllFiles = true;
      AppleShowAllExtensions = true;
      CreateDesktop = false;
    };
    LaunchServices.LSQuarantine = false;
  };
  
  homebrew = {
    enable = true;
    onActivation = {
      upgrade = true;
      autoUpdate = true;
    };
    casks = [
      "whatsapp"
      "telegram"
      "slack"
      "docker"
      "discord"
      "karabiner-elements"
      "signal"
      "raycast"
      "zen-browser"
    ];
  };

  nixpkgs.config.allowUnfree = true;
}
