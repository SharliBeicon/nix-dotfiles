{
  pkgs,
  inputs,
  ...
}: {
  home.username = "charliebacon";
  home.homeDirectory = "/Users/charliebacon";
  home.stateVersion = "24.11";
  home.packages = with pkgs; [
    awscli2
    brave
    buf
    bun
    cmake
    deno
    eza
    ffmpeg
    gdal
    git-lfs
    grpcurl
    jankyborders
    jj
    jq
    just
    kind
    kubectx
    kubectl
    lazygit
    macchina
    meson
    mise
    nb
    nerd-fonts.iosevka
    ninja
    nodejs
    obsidian
    odin
    onefetch
    protobuf
    python311
    ripgrep
    sdl3
    sops
    terraform
    terragrunt
    tokei
    unar
    uv
    yamlfmt
    yazi
    zig
  ];

  home.file = {
    ".config/btop/themes/gruvbox_material_dark.theme" = {
      source = ../../files/btop/themes/gruvbox_material_dark.theme;
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
    rgf = "rg --files | rg";
    love="/Applications/love.app/Contents/MacOS/love";
  };

  programs = {
    home-manager.enable = true;
    zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
    fzf = {
      enable = true;
      enableFishIntegration = true;
    };
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
      lfs.enable = true;
      userName = "Charlie Bacon";
      userEmail = "me@charliebacon.dev";
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
    k9s.enable = true;
    wezterm = {
      enable = true;
      extraConfig = ''
        return {
          bold_brightens_ansi_colors = "BrightAndBold",
          font = wezterm.font("Iosevka Nerd Font"),
          color_scheme = "gruvbox_material_dark_hard",
          color_schemes = {
            ["gruvbox_material_dark_hard"] = {
              foreground = "#D4BE98",
              background = "#1D2021",
              cursor_bg = "#D4BE98",
              cursor_border = "#D4BE98",
              cursor_fg = "#1D2021",
              selection_bg = "#D4BE98" ,
              selection_fg = "#3C3836",

              ansi = {"#1d2021","#ea6962","#a9b665","#d8a657", "#7daea3","#d3869b", "#89b482","#d4be98"},
              brights = {"#eddeb5","#ea6962","#a9b665","#d8a657", "#7daea3","#d3869b", "#89b482","#d4be98"}
            },
            ["gruvbox_material_light_hard"] = {
                foreground = "#654735",
                background = "#F9F5D7",
                cursor_bg = "#654735",
                cursor_border = "#654735",
                cursor_fg = "#F9F5D7",
                selection_bg = "#F3EAC7" ,
                selection_fg = "#4F3829",

                ansi = {"#1d2021","#ea6962","#a9b665","#d8a657", "#7daea3","#d3869b", "#89b482","#d4be98"},
                brights = {"#eddeb5","#ea6962","#a9b665","#d8a657", "#7daea3","#d3869b", "#89b482","#d4be98"}
            },
          },
          font_size = 19.0,
          window_background_opacity = 0.96,
          window_decorations = "RESIZE | MACOS_FORCE_ENABLE_SHADOW",
          keys = {
            -- Close panes with shift+w.
            {
              key = "w",
              mods = "CMD|SHIFT",
              action = wezterm.action.CloseCurrentPane { confirm = true },
            },
            -- Vim-style hjkl navigation between panes.
            {
              key = "h",
              mods = "CMD|SHIFT",
              action = wezterm.action.ActivatePaneDirection("Left"),
            },
            {
              key = "j",
              mods = "CMD|SHIFT",
              action = wezterm.action.ActivatePaneDirection("Down"),
            },
            {
              key = "k",
              mods = "CMD|SHIFT",
              action = wezterm.action.ActivatePaneDirection("Up"),
            },
            {
              key = "l",
              mods = "CMD|SHIFT",
              action = wezterm.action.ActivatePaneDirection("Right"),
            },
            -- iTerm-style cmd-d/cmd-shift-d pane splitting.
            {
              key = "d",
              mods = "CMD",
              action = wezterm.action.SplitPane({direction = "Right"})
            },
            {
              key = "d",
              mods = "CMD|SHIFT",
              action = wezterm.action.SplitPane({direction = "Down"})
            },
            -- iTerm-style cmd-shift-enter pane zoom toggle.
            {
              key = "Enter",
              mods = "CMD|SHIFT",
              action = wezterm.action.TogglePaneZoomState,
            },
            -- Scroll between prompts.
            {
              key = "UpArrow",
              mods = "CMD|SHIFT",
              action = wezterm.action.ScrollToPrompt(-1),
            },
            {
              key = "DownArrow",
              mods = "CMD|SHIFT",
              action = wezterm.action.ScrollToPrompt(1),
            },
            -- Type a hash symbol.
            {
              key = "3",
              mods = "OPT",
              action = wezterm.action.SendString("#"),
            },
          },
          hide_tab_bar_if_only_one_tab = true,
          mouse_bindings = {
            {
              event = { Down = { streak = 3, button = 'Left' } },
              action = wezterm.action.SelectTextAtMouseCursor 'SemanticZone',
              mods = 'NONE',
            },
          },
          scrollback_lines = 100000,
          use_fancy_tab_bar = true,
        }
      '';
    };
    starship = {
      enable = true;
      enableFishIntegration = true;
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
          ahead = "[⬆ ](bold purple) ";
          behind = "[⬇ ](bold purple) ";
          staged = "[✚ ](green) ";
          deleted = "[✖ ](red) ";
          renamed = "[➜ ](purple) ";
          stashed = "[✭](cyan) ";
          untracked = "[◼ ](white) ";
          modified = "[✱ ](blue) ";
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
        color_theme = "gruvbox_material_dark.theme";
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
    zsh.enable = true;
    fish = {
      enable = true;
      plugins = [
        {
          name = "fzf";
          src = pkgs.fetchFromGitHub {
            owner = "PatrickF1";
            repo = "fzf.fish";
            rev = "6d8e962f3ed84e42583cec1ec4861d4f0e6c4eb3";
            sha256 = "sha256-0rnd8oJzLw8x/U7OLqoOMQpK81gRc7DTxZRSHxN9YlM";
          };
        }
      ];
      shellInit = ''
        # Set syntax highlighting colours; var names defined here:
        # http://fishshell.com/docs/current/index.html#variables-color
        set fish_color_normal normal
        set fish_color_command white
        set fish_color_quote brgreen
        set fish_color_redirection brblue
        set fish_color_end white
        set fish_color_error -o brred
        set fish_color_param brpurple
        set fish_color_comment --italics brblack
        set fish_color_match cyan
        set fish_color_search_match --background=brblack
        set fish_color_operator cyan
        set fish_color_escape white
        set fish_color_autosuggestion brblack
      '';
      # Send OSC 133 escape sequences to signal prompt and ouput start and end.
      interactiveShellInit = ''
        function terminal_integration_preprompt --on-event fish_prompt
          printf "\033]133;A;\007"
        end

        # TODO not used yet.
        function terminal_integration_postprompt
          printf "\033]133;B;\007"
        end

        function terminal_integration_preexec --on-event fish_preexec
          printf "\033]133;C;\007"
        end

        function terminal_integration_postexec --on-event fish_postexec
          printf "\033]133;D;\007"
        end
      '';
      shellAbbrs = {
        g = "git";
        ga = "git add";
        gap = "git add -p";
        gb = "git branch";
        gc = "git commit";
        gca = "git commit --amend";
        gcan = "git commit --amend --no-edit";
        gcm = "git commit -m";
        gmr = "git merge";
        gcl = "git clone";
        gd = "git diff";
        gds = "git diff --staged";
        gl = "git prettylog";
        gp = "git pull";
        gP = "git push";
        gPf = "git push --force-with-lease";
        gpp = "git pull --prune";
        gr = "git restore";
        grs = "git restore --staged";
        grb = "git rebase";
        grba = "git rebase --abort";
        grbc = "git rebase --continue";
        grbi = "git rebase -i";
        gs = "git status -s -b";
        gst = "git stash";
        gstp = "git stash pop";
        gsts = "git stash show -p";
        gstx = "git stash drop";
        gsw = "git switch";
        gswc = "git switch -c";
        gswm = "git switch main";
      };
      functions = {
        fish_greeting = {
          description = "Greeting to show when starting a fish shell";
          body = "";
        };
      };
    };
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };

  xdg.configFile.nvim = {
    source = ../../nvim;
    recursive = true;
  };
}
