{ pkgs , ... }: {
  home.username = "carlostocinocubelo";
  home.homeDirectory = "/Users/carlostocinocubelo";
  home.stateVersion = "24.11";
    home.packages = with pkgs; [
      pyenv
      nodejs
      deno
      zsh-autosuggestions
      zoxide
      thefuck
      macchina
      btop
      yazi
      odin
      cmake
      protobuf
      awscli2
      kubectl
      sops
      jq
      ffmpeg
      lazygit
      zig
      ripgrep
      uv
      unar
      eza
      fzf
      (nerdfonts.override { fonts = [ "FiraCode" "Iosevka" ]; })
      fira-code
      iosevka
      terraform
      terragrunt
    ];

  home.file = {
    ".config/btop/themes/catppuccin_mocha.theme" = {
      source = ../files/btop/themes/catppuccin_mocha.theme;
    };
    ".config/kitty/themes/gruvbox_dark.conf" = {
      source = ../files/kitty/themes/gruvbox_dark.conf;
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.shellAliases = {
    db = "cd ~/Developer/DataBeacon/";
    p = "cd ~/Developer/Personal/";
    a = "cd ~/Developer/DataBeacon/analytics/";
    t = "cd ~/Developer/DataBeacon/tango5/";
    vim = "nvim";
    awslogin = "aws sso login --sso-session Databeacon";
    ls = "eza";
    zbr = "zig build run";
    or = "odin run .";
    rgf = "rg --files | rg";
  };

  programs = {
    home-manager.enable = true;
    bat = {
      enable = true;
      config = {
        theme = "gruvbox-dark";
        italic-text = "always";
      };
    };
    gh = {
      enable = true;
      settings = {
        git_protocol = "ssh";
      };
    };
    git = {
      enable = true;
      userName = "Charlie Bacon";
      userEmail = "carlostocinocubelo@gmail.com";
      aliases = {
        prettylog = "log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
      };
      delta = {
        enable = true;
        # Custom `delta` executable whichs sets light/dark feature
        # depending on OS appearance.
        package = pkgs.writeShellApplication {
          name = "delta";
          runtimeInputs = [pkgs.delta];
          text = ''
            features=$(defaults read -globalDomain AppleInterfaceStyle > /dev/null 2>&1 && printf dark-mode || printf light-mode)
            env DELTA_FEATURES="$features" ${pkgs.delta}/bin/delta "$@"
          '';
        };
        options = {
          light-mode = {
            light = true;
            syntax-theme = "GitHub";
          };
          dark-mode = {
            dark = true;
            syntax-theme = "OneHalfDark";
          };
          features = "light-mode";
          navigate = true;
          line-numbers = true;
        };
      };
      extraConfig = {
        core = {
          # If git uses `ssh` from Nix the macOS-specific configuration in
          # `~/.ssh/config` won't be seen as valid
          # https://github.com/NixOS/nixpkgs/issues/15686#issuecomment-865928923
          sshCommand = "/usr/bin/ssh";
        };
        color = {
          ui = true;
        };
        diff = {
          colorMoved = "default";
        };
        merge = {
          conflictstyle = "zdiff3";
        };
        push = {
          default = "current";
        };
        pull = {
          ff = "only";
        };
        init = {
          defaultBranch = "main";
        };
        url."git@github.com:" = {
          insteadOf = "gh:";
          pushInsteadOf = "gh:";
        };
      };
      ignores = [
        ".*.swp"
        ".bundle"
        "vendor/bundle"
        ".DS_Store"
        "Icon"
        "*.pyc"
        ".direnv"
      ];
    };
    kitty = {
      enable = true;

      settings = {
        background_opacity = "1.0";
        font_family = "Iosevka Nerd Font Mono";
        font_size = "18.0";
        cursor_shape = "block";
        window_padding_width = "8";

        initial_window_width = "175c";
        initial_window_height = "41c";
        enabled_layouts = "grid";
        include = "themes/gruvbox_dark.conf";
      };

      keybindings = {
        "ctrl+super+enter" = "toggle_layout stack";
        "ctrl+super+h" = "neighboring_window left";
        "ctrl+super+l" = "neighboring_window right";
        "ctrl+super+k" = "neighboring_window up";
        "ctrl+super+j" = "neighboring_window down";
        "shift+up" =  "move_window up";
        "shift+left" =  "move_window left";
        "shift+right" = "move_window right";
        "shift+down" =  "move_window down";
        "super+l" = "launch --location=hsplit";
        "super+k" = "launch --location=vsplit";
      };
    };
    starship = {
      enable = true;
      settings = {
        format = "$directory$status$all$character";

        character = {
          success_symbol = "[❯](red)[❯](yellow)[❯](green)";
          error_symbol = "[❯](red)[❯](yellow)[❯](green)";
          vicmd_symbol = "[❮](green)[❮](yellow)[❮](red)";
        };

        git_branch = {
          symbol = " ";
          format = "[$branch]($style) ";
          style = "bold green";
        };

        python = {
          symbol = " ";
          format = "\\($virtualenv\\) ";
        };

        git_status = {
          format = "$all_status$ahead_behind ";
          ahead = "[⬆](bold purple) ";
          behind = "[⬇](bold purple) ";
          staged = "[✚](green) ";
          deleted = "[✖](red) ";
          renamed = "[➜](purple) ";
          stashed = "[✭](cyan) ";
          untracked = "[◼](white) ";
          modified = "[✱](blue) ";
          conflicted = "[═](yellow) ";
          diverged = "⇕ ";
          up_to_date = "";
        };

        directory = {
          read_only = " 󰌾";
          style = "blue";
          truncation_length = 1;
          truncation_symbol = "";
          fish_style_pwd_dir_length = 1;
        };

        cmd_duration.format = "[$duration]($style) ";
        status = {
          disabled = false;
          symbol = "✘ ";
        };

        aws.symbol = "  ";
        buf.symbol = " ";
        c.symbol = " ";
        conda.symbol = " ";
        crystal.symbol = " ";
        dart.symbol = " ";
        docker_context.symbol = " ";
        elixir.symbol = " ";
        elm.symbol = " ";
        fennel.symbol = " ";
        fossil_branch.symbol = " ";
        golang.symbol = " ";
        guix_shell.symbol = " ";
        haskell.symbol = " ";
        haxe.symbol = " ";
        hg_branch.symbol = " ";
        hostname.ssh_symbol = " ";
        java.symbol = " ";
        julia.symbol = " ";
        kotlin.symbol = " ";
        lua.symbol = " ";
        memory_usage.symbol = "󰍛 ";
        meson.symbol = "󰔷 ";
        nim.symbol = "󰆥 ";
        nix_shell.symbol = " ";
        nodejs.symbol = " ";
        ocaml.symbol = " ";

        os.symbols = {
          Alpaquita = " ";
          Alpine = " ";
          AlmaLinux = " ";
          Amazon = " ";
          Android = " ";
          Arch = " ";
          Artix = " ";
          CentOS = " ";
          Debian = " ";
          DragonFly = " ";
          Emscripten = " ";
          EndeavourOS = " ";
          Fedora = " ";
          FreeBSD = " ";
          Garuda = "󰛓 ";
          Gentoo = " ";
          HardenedBSD = "󰞌 ";
          Illumos = "󰈸 ";
          Kali = " ";
          Linux = " ";
          Mabox = " ";
          Macos = " ";
          Manjaro = " ";
          Mariner = " ";
          MidnightBSD = " ";
          Mint = " ";
          NetBSD = " ";
          NixOS = " ";
          OpenBSD = "󰈺 ";
          openSUSE = " ";
          OracleLinux = "󰌷 ";
          Pop = " ";
          Raspbian = " ";
          Redhat = " ";
          RedHatEnterprise = " ";
          RockyLinux = " ";
          Redox = "󰀘 ";
          Solus = "󰠳 ";
          SUSE = " ";
          Ubuntu = " ";
          Unknown = " ";
          Void = " ";
          Windows = "󰍲 ";
        };

        package.symbol = "󰏗 ";
        perl.symbol = " ";
        php.symbol = " ";
        pijul_channel.symbol = " ";
        rlang.symbol = "󰟔 ";
        ruby.symbol = " ";
        rust.symbol = "󱘗 ";
        scala.symbol = " ";
        swift.symbol = " ";
        zig.symbol = " ";
      };
    };
    btop = {
      enable = true;
      settings = {
        color_theme = "catppuccin_mocha.theme";
        theme_background = true;
        truecolor = true;
        force_tty = false;

        presets = "cpu:1:default,proc:0:default cpu:0:default,mem:0:default,net:0:default cpu:0:block,net:0:tty";
        vim_keys = false;
        rounded_corners = true;

        graph_symbol = "braille";
        graph_symbol_cpu = "default";
        graph_symbol_mem = "default";
        graph_symbol_net = "default";
        graph_symbol_proc = "default";

        shown_boxes = "cpu mem proc";
        update_ms = 2000;

        proc_sorting = "cpu lazy";
        proc_reversed = false;
        proc_tree = true;
        proc_colors = true;
        proc_gradient = true;
        proc_per_core = false;
        proc_mem_bytes = true;
        proc_cpu_graphs = true;
        proc_info_smaps = false;
        proc_left = false;
        proc_filter_kernel = false;
        proc_aggregate = false;

        cpu_graph_upper = "Auto";
        cpu_graph_lower = "Auto";
        cpu_invert_lower = true;
        cpu_single_graph = false;
        cpu_bottom = false;
        show_uptime = true;
        check_temp = true;
        cpu_sensor = "Auto";
        show_coretemp = true;
        cpu_core_map = "";
        temp_scale = "celsius";
        base_10_sizes = false;
        show_cpu_freq = true;

        clock_format = "%X";
        background_update = true;
        custom_cpu_name = "";

        disks_filter = "";
        mem_graphs = true;
        mem_below_net = false;
        zfs_arc_cached = true;
        show_swap = true;
        swap_disk = true;
        show_disks = true;
        only_physical = true;
        use_fstab = true;
        zfs_hide_datasets = false;
        disk_free_priv = false;
        show_io_stat = true;
        io_mode = false;
        io_graph_combined = false;
        io_graph_speeds = "";

        net_download = 100;
        net_upload = 100;
        net_auto = true;
        net_sync = true;
        net_iface = "";

        show_battery = true;
        selected_battery = "Auto";
        show_battery_watts = true;

        log_level = "WARNING";
      };
    };
    zsh = {
      enable = true;
      oh-my-zsh.enable = true;
      oh-my-zsh.plugins = [ "git" "z" "fzf" ];
      oh-my-zsh.theme = "robbyrussell";

      initExtra = ''
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

        autoload -U add-zsh-hook
        add-zsh-hook chpwd use_nvmrc
        use_nvmrc() {
          if [[ -f .nvmrc && -r .nvmrc ]]; then
            nvm use
          fi
        }
        use_nvmrc

        export PYENV_ROOT="$HOME/.pyenv"
        export PATH="$PYENV_ROOT/bin:$PATH"
        eval "$(pyenv init --path)"
        eval "$(pyenv init -)"

        export PROTO_HOME="$HOME/.proto"
        export PATH="$PROTO_HOME/shims:$PROTO_HOME/bin:$PATH"
      '';
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };

  xdg.configFile.nvim = {
    source = ../nvim;
    recursive = true;
  };
}
