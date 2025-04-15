{
  config,
  pkgs,
  inputs,
  ...
}: {
  system.stateVersion = 6;
  
  nix.extraOptions = ''
    # Settings copied from those written by
    # https://github.com/DeterminateSystems/nix-installer, version 0.11.0.
    extra-nix-path = nixpkgs=flake:nixpkgs
    bash-prompt-prefix = (nix:$name)\040
    experimental-features = nix-command flakes auto-allocate-uids
    build-users-group = nixbld
  '';

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
    brews = [
      "postgresql"
    ];
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
