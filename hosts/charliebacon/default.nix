{
  config,
  pkgs,
  inputs,
  ...
}: {
  system.stateVersion = 6;
  system.primaryUser = "charliebacon";

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
      "zerotier-one"
      "whatsapp"
      "telegram"
      "slack"
      "docker"
      "discord"
      "karabiner-elements"
      "signal"
      "raycast"
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
          yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"
          sudo yabai --load-sa

          yabai -m config top_padding    12
          yabai -m config bottom_padding 12
          yabai -m config left_padding   12
          yabai -m config right_padding  12
          yabai -m config window_gap     12

          yabai -m config mouse_follows_focus on

          yabai -m config window_opacity on
          yabai -m config active_window_opacity 1.0
          yabai -m config normal_window_opacity 0.9

          yabai -m config external_bar all:32:0

          yabai -m rule --add app="^System Settings$" manage=off
          yabai -m rule --add app="^Activity Monitor$" manage=off
          yabai -m rule --add app="^love$" manage=off
          
          borders active_color=0xffe1e3e4 inactive_color=0xff494d64 width=3.0 &
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

        alt + cmd - 1 : yabai -m space --focus 1
        alt + cmd - 2 : yabai -m space --focus 2
        alt + cmd - 3 : yabai -m space --focus 3
        alt + cmd - 4 : yabai -m space --focus 4
        alt + cmd - 5 : yabai -m space --focus 5
        alt + cmd - 6 : yabai -m space --focus 6
        alt + cmd - 7 : yabai -m space --focus 7
        alt + cmd - 8 : yabai -m space --focus 8
        alt + cmd - 9 : yabai -m space --focus 9

        alt - return : yabai -m window --warp mouse
      '';
    };
  };

  nixpkgs.config.allowUnfree = true;
}
