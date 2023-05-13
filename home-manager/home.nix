# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      inputs.neovim-nightly-overlay.overlay

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  fonts.fontconfig.enable = true;

  # Set your username
  home = {
    username = "pirey";
    homeDirectory = "/home/pirey";
    stateVersion = "22.11"; # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  };

  # Add stuff for your user as you see fit:
  # home.packages = with pkgs; [ steam ];
  home.packages = with pkgs; [
    nodejs
    lazygit
    ripgrep
    fd
    gcc
    neovim-nightly
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    xclip
    xcape
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  programs.fish = {
    enable = true;
    shellAbbrs = {
      l = "ls -alh";

      ".." = "cd ..";
      "cd.." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";

      prettier-here = "prettier --write --ignore-path .gitignore";

      # tmux
      tkill = "tmux kill-server";
      tmain = "tmux a -t main";
      tmux = "tmux -u";

      sizeof = "du -h -d 0";

      ls-dir = "ls -d */";

      # typo sucks
      im = "nvim";
      vmi = "nvim";
      nvi = "nvim";
      vim = "nvim";
      vm = "nvim";
      vi = "nvim";
      v = "nvim";

      # git
      gconf = "vim $HOME/.gitconfig";
      gst = "git status";
      gdif = "git diff";
      ginit = "git init && git add . && git commit -m 'init'";
      gad = "git add .";
      gac = "git add . && git commit -m";
      gca = "git add . && git commit --amend";
      gcn = "git commit --amend --no-edit";
      gc = "git commit -m";
      gp = "git push";
      gprun = "git fetch --prune";
      lgit = "lazygit";
    };
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  editorconfig = {
    enable = true;
    settings = {
      "*" = {
        end_of_line = "lf";
        insert_final_newline = true;
        indent_style = "space";
        indent_size = 4;
        charset = "utf-8";
        trim_trailing_whitespace = true;
      };
      "*.{c,cpp,h,go}" = {
        indent_style = "tab";
        tab_width = 4;
      };
      "*.{coffee}" = {
        indent_style = "tab";
        tab_width = 2;
      };
      "*.{hs,rb,rest,jade,pug,yml,json,html,css,re,js,jsx,ts,tsx,njk,vue}" = {
        indent_size = 2;
      };
      "*.{elm}" = {
        indent_size = 4;
      };
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";
}
