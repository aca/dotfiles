{
  description = "git-worktree.nvim - supercharge your haskell experience in neovim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neorocks.url = "github:nvim-neorocks/neorocks";
    gen-luarc.url = "github:mrcjkb/nix-gen-luarc-json";

    # neovim = {
    #   url = "github:neovim/neovim?dir=contrib";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # neodev-nvim = {
    #   url = "github:folke/neodev.nvim";
    #   flake = false;
    # };
    # plenary-nvim = {
    #   url = "github:nvim-lua/plenary.nvim";
    #   flake = false;
    # };
    # telescope-nvim = {
    #   url = "github:nvim-telescope/telescope.nvim";
    #   flake = false;
    # };
  };

  outputs = inputs @ {
    self,
    flake-parts,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
        "x86_64-linux"
      ];
      perSystem = {
        config,
        pkgs,
        system,
        inputs',
        ...
      }: let
        luarc-plugins = with pkgs.lua51Packages; (with pkgs.vimPlugins; [
          telescope-nvim
          plenary-nvim
        ]);

        luarc-nightly = pkgs.mk-luarc {
          nvim = pkgs.neovim-nightly;
          plugins = luarc-plugins;
        };

        luarc-stable = pkgs.mk-luarc {
          nvim = pkgs.neovim-unwrapped;
          plugins = luarc-plugins;
          disabled-diagnostics = [
            #"undefined-doc-name"
            #"redundant-parameter"
            #"invisible"
          ];
        };

        pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
          src = self;
          hooks = {
            alejandra.enable = true;
            stylua.enable = true;
            luacheck.enable = true;
            #markdownlint.enable = true;
          };
        };
      in {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [
            inputs.neorocks.overlays.default
            inputs.gen-luarc.overlays.default
            (final: _: {
              # neovim-nightly = inputs.neovim.packages.${final.system}.neovim;
            })
          ];
        };
        devShells = let
          mkDevShell = luaVersion: let
            luaEnv = pkgs."lua${luaVersion}".withPackages (lp:
              with lp; [
                busted
                luacheck
                luarocks
              ]);
          in
            pkgs.mkShell {
              buildInputs = [
                luaEnv
              ];
              shellHook = let
                myVimPackage = with pkgs.vimPlugins; {
                  start = [
                    plenary-nvim
                  ];
                };
                packDirArgs.myNeovimPackages = myVimPackage;
              in
                pre-commit-check.shellHook
                + ''
                  export DEBUG_PLENARY="debug"
                  cat <<-EOF > minimal.vim
                    set rtp+=.
                    set packpath^=${pkgs.vimUtils.packDir packDirArgs}
                  EOF
                '';
            };
        in {
          default = let
          in
            pkgs.mkShell {
              name = "git-worktree-nvim-shell";
              shellHook = ''
                ${pre-commit-check.shellHook}
                ln -fs ${pkgs.luarc-to-json luarc-nightly} .luarc.json
              '';
              buildInputs =
                self.checks.${system}.pre-commit-check.enabledPackages
                ++ (with pkgs; [
                  lua-language-server
                  busted-nlua
                  (lua5_1.withPackages (ps:
                    with ps; [
                      luarocks
                      plenary-nvim
                    ]))
                  git-cliff
                ]);
            };
        };

        packages = let
          docgen = pkgs.callPackage ./nix/docgen.nix {};
        in {
          inherit docgen;
        };
        # packages.neodev-plugin = pkgs.vimUtils.buildVimPlugin {
        #   name = "neodev.nvim";
        #   src = inputs.neodev-nvim;
        # };
        # packages.plenary-plugin = pkgs.vimUtils.buildVimPlugin {
        #   name = "plenary.nvim";
        #   src = inputs.plenary-nvim;
        # };
        # packages.telescope-plugin = pkgs.vimUtils.buildVimPlugin {
        #   name = "telescope.nvim";
        #   src = inputs.telescope-nvim;
        # };

        checks = let
          type-check-stable = inputs.pre-commit-hooks.lib.${system}.run {
            src = self;
            hooks = {
              lua-ls = {
                enable = true;
                settings.configuration = luarc-stable;
              };
            };
          };

          type-check-nightly = inputs.pre-commit-hooks.lib.${system}.run {
            src = self;
            hooks = {
              lua-ls = {
                enable = true;
                settings.configuration = luarc-nightly;
              };
            };
          };

          neorocks-test = pkgs.neorocksTest {
            src = self; # Project containing the rockspec and .busted files.
            # Plugin name. If running multiple tests,
            # you can use pname for the plugin name instead
            name = "git-worktree.nvim";
            # version = "scm-1"; # Optional, defaults to "scm-1";
            neovim = pkgs.neovim-nightly; # Optional, defaults to neovim-nightly.
            luaPackages = ps:
            # Optional
              with ps; [
                # LuaRocks dependencies must be added here.
                plenary-nvim
              ];
            extraPackages = with pkgs; [
              gitMinimal
            ]; # Optional. External test runtime dependencies.
          };
        in {
          inherit pre-commit-check;
          inherit type-check-stable;
          inherit type-check-nightly;
          inherit neorocks-test;
        };
      };
    };
}
