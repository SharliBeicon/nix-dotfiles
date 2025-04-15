# Charlie Bacon's dotfiles

Here is my system configuration, it's managed by Nix with `home-manager` and `nix-darwin`. All you need to set it up is a fresh installation of MacOS and follow the next steps:

> [!TIP]
> Note that a `charliebacon` MacOS user is expected and everything is built around it, if you want to use this flake with your own user, you will need to clone/fork the repo, change all occurrencies of `charliebacon` with the name of your MacOS user and proceed

#### 1. MacOS build essentials

```bash
$ xcode-install
```

#### 2. One line to rule them all

This command will install Nix in the system, active the Nix daemon and load the repo flake using `nix-darwin`

```bash
$ curl -L https://nixos.org/nix/install | sh && \
. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh && \
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake github:sharlibeicon/nix-dotfiles#charliebacon
```

#### 3. Enable fish shell

Although a default instance of zsh is installed within the flake, I like to use fish shell, which is also installed, but it needs a bit of configuration:

1. Add fish binary to `/etc/shells`:

   Edit the file and add this line: `/etc/profiles/per-user/charliebacon/bin/fish`

1. Enable fish shell and make it aware of the specific paths of Nix running these commands:

```shell
$ fish
$ fish_add_path /run/current-system/sw/bin/
$ fish_add_path /etc/profiles/per-user/charliebacon/bin/
```

3. Make fish your default shell:

```shell
$ chsh -s /etc/profiles/per-user/charliebacon/bin/fish
```

#### 4. Change it when you want

To make changes to your config, you will need to clone the repo to e.g. `~/dotfiles`:

```shell
$ git clone https://github.com/SharliBeicon/nix-dotfiles.git ~/dotfiles
```

Then make all the config/packages changes you want and reload the flake to make your system aware of those changes with:

```shell
$ darwin-rebuild switch --flake ~/dotfiles#charliebacon
```
