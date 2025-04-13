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
    ];
  };

  nixpkgs.config.allowUnfree = true;
}
