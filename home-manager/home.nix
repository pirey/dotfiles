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

  programs.git = {
    enable = true;
    extraConfig = {
      core = {
        editor = "nvim -u NONE";
      };
      pretty = {
        custom = "%Cred%h%Creset - %C(bold blue)<%an>%C(yellow)%d%Creset %s %Cgreen(%cr) %Creset";
      };
    };
    includes = [
      {
        path = "~/.gitconfig.local";
      }
    ];
    aliases = {
      l = "log --pretty=custom --abbrev-commit";
      la = "log --branches --remotes --tags --oneline --decorate";
      gap = "log --left-right --oneline --decorate";
      compare = "log --left-right --oneline --decorate";
      co = "checkout";
      # list-files = show --format=\"\" --name-status
      list-files = "diff-tree --no-commit-id --name-status -r";
      # show all branch order by last commit
      br = "for-each-ref --sort=-committerdate refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'";
      stash = "stash -u";
      rlog = "reflog --date=local";
      logno = "log --no-merges";
      confg = "config --global --list";
      committer = "shortlog -s -n --all";

      # Find commits by code.

      fc = "!f() { \
          git log --pretty=custom --decorate --date=short -S\"$1\"; \
      }; f";

      # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

      # Find commits by commit message.

      fm = "!f() { \
          git log --pretty=custom --decorate --date=short --grep=\"$1\"; \
      }; f";
    };
    ignores = [
      "*.keystore"

      "*~"
      ".DS_Store"

      ".eslintcache"
      "node_modules/*"
      ".vscode"
      "*.swp"

      # python
      ".venv"
    ];
  };

  programs.fish = {
    enable = true;
    shellAbbrs = {
      l = "ls -alh";
      z = "zoxide";

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

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    colors = {
      fg = "#c0caf5";
      bg = "#1a1b26";
      hl = "#bb9af7";
      "bg+" = "#1a1b26";
      "fg+" = "#c0caf5";
      "hl+" = "#7dcfff";
      info = "#7aa2f7";
      prompt = "#7dcfff";
      pointer = "#7dcfff";
      marker = "#9ece6a";
      spinner = "#9ece6a";
      header = "#9ece6a";
    };
  };

  programs.zoxide = {
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
        indent_size = 2;
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
