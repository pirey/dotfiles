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

      (final: prev: {
        unstable = import inputs.nixpkgs-unstable {
          system = final.system;
          allowUnfree = true;
        };
      })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  fonts.fontconfig.enable = true;

  # Set your username
  home = {
    username = "pirey";
    homeDirectory = "/home/pirey";
    stateVersion = "22.11"; # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Add stuff for your user as you see fit:
  # home.packages = with pkgs; [ steam ];
  home.packages = with pkgs; [
    gnumake
    postman
    nodejs
    deno
    lazygit
    ripgrep
    fd
    gcc
    neovim-nightly
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    xclip
    wl-clipboard
    xcape
    stylua
    chromium
    lua-language-server
    supabase-cli
  ];

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

  # Enable home-manager and git
  programs.home-manager.enable = true;

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    escapeTime = 0;
    keyMode = "vi";
    historyLimit = 50000;
    customPaneNavigationAndResize = true;
    mouse = true;
    prefix = "C-space";
    resizeAmount = 10;
    terminal = "tmux-256color";
    extraConfig = ''
      # toggle status line
      bind-key S set -g status

      bind-key \\ split-window -h -c '#{pane_current_path}' # split panes horizontal
      bind-key - split-window -v -c '#{pane_current_path}' # split panes vertically

      bind-key > swap-window -d -t +1
      bind-key < swap-window -d -t -1

      # clipboard
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-selection
      bind-key -T copy-mode-vi r send-keys -X rectangle-toggle

      # theme
      # nord bg = #2E3440
      # tokyonight bg = #222436
      set -g status-justify "left"
      set -g status "on"
      set -g status-left-style "none"
      set -g message-command-style "fg=#3B4252,bg=#81A1C1"
      set -g status-right-style "none"
      set -g pane-active-border-style "fg=#3b4252"
      set -g status-style "none,bg=#222436"
      set -g message-style "fg=#3B4252,bg=#81A1C1"
      set -g pane-border-style "fg=#2e3440"
      set -g status-right-length "100"
      set -g status-left-length "100"
      setw -g window-status-activity-style "none,fg=#8FBCBB,bg=#222436"
      setw -g window-status-separator ""
      setw -g window-status-style "none,fg=#E5E9F0,bg=#222436"

      set -g status-left ""
      set -g status-right " #F #W #[fg=#555555,bg=#222436] #S #[fg=#222436,bg=#222436,nobold,nounderscore,noitalics]"
      setw -g window-status-format "#[fg=#555555,bg=#222436] #I #[fg=#222436,bg=#222436,nobold,nounderscore,noitalics]"
      setw -g window-status-current-format "#[fg=#dfdfdf,bg=#222436] ■ #[fg=#81A1C1,bg=#222436,nobold,nounderscore,noitalics]"
    '';
  };

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

  programs.kitty = {
    enable = true;
    font.name = "JetBrains Mono";
    font.size = 10;
    keybindings = {
      f11 = "toggle_fullscreen";
    };
    settings = {
      window_padding_width = 0;
      tab_bar_style = "hidden";
    };
    theme = "Tokyo Night Moon";
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # profileExtra = ''
    #   source ~/dotfiles/scripts/keyboard.sh
    # '';
    bashrcExtra = ''
      if [ -f ~/.bash_impure ] ; then
        source ~/.bash_impure
      fi
    '';
    shellAliases = {
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
      nvm = "nvim";
      vim = "nvim";
      vm = "nvim";
      vi = "nvim";
      v = "nvim";
      n = "nvim";

      # git
      g = "git";
      gconf = "vim $HOME/.gitconfig";
      gst = "git status";
      gdif = "git diff";
      ginit = "git init && git add . && git commit -m 'init'";
      gad = "git add .";
      gac = "git add . && git commit -m";
      gca = "git add . && git commit --amend";
      gcn = "git commit --amend --no-edit";
      gco = "git checkout";
      gc = "git commit -m";
      gp = "git push";
      gb = "git branch";
      gba = "git branch --all";
      gbr = "git branch -r";
      gprun = "git fetch --prune";
      lgit = "lazygit";
    };
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
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
    enableBashIntegration = true;
  };

  programs.go = {
    enable = true;
  };
}
