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
      "sketchybar"
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
      "font-hack-nerd-font"
    ];
  };

  services = {
    yabai = {
      enable = true;
      enableScriptingAddition = true;
      config = {
        layout = "bsp";
        auto_balance = "on";
        window_placementt = "second_child";
        extraConfig = ''
          yabai -m config top_padding    10
          yabai -m config bottom_padding 10
          yabai -m config left_padding   10
          yabai -m config right_padding  10
          yabai -m config window_gap     10

          yabai -m config mouse_follows_focus on

          yabai -m config window_opacity on
          yabai -m config active_window_opacity 1.0
          yabai -m config normal_window_opacity 0.9

          yabai -m config external_bar all:30:0

          yabai -m rule --add app="^System Settings$" manage=off
        '';
      };
    };
    skhd = {
      enable = true;
      skhdConfig = ''
        # Basic skhd config
        alt - h : yabai -m window --focus west
        alt - l : yabai -m window --focus east
        alt - k : yabai -m window --focus north
        alt - j : yabai -m window --focus south

        alt - return : yabai -m window --warp mouse
      '';
    };
  };

  nixpkgs.config.allowUnfree = true;
}
