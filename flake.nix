{
  inputs.nix2container.url = "github:nlewo/nix2container";

  outputs = { self, nixpkgs, nix2container }:
    let
      l = pkgs.lib // builtins;

      user = "root";
      group = "root";
      uid = "0";
      gid = "0";

      pkgs = import nixpkgs { system = "x86_64-linux"; };
      nix2containerPkgs = nix2container.packages.x86_64-linux;
      # not working
      # dotfiles = fetchGit {
      #     url = "https://gitlab.com/acadx0/dotfiles.git";
      #     ref = "master";
      #     rev = "082a06a7d8478b72c896ff09543c0a58ec2ed774";
      #   };
      #
      mkUser = pkgs.runCommand "mkUser" { } ''
        mkdir -p $out/etc/pam.d

        echo "${user}:x:${uid}:${gid}::" > $out/etc/passwd
        echo "${user}:!x:::::::" > $out/etc/shadow

        echo "${group}:x:${gid}:" > $out/etc/group
        echo "${group}:x::" > $out/etc/gshadow

        cat > $out/etc/pam.d/other <<EOF
        account sufficient pam_unix.so
        auth sufficient pam_rootok.so
        password requisite pam_unix.so nullok sha512
        session required pam_unix.so
        EOF

        touch $out/etc/login.defs
        mkdir -p $out/home/${user}
      '';
      #
    in
    {
      packages.x86_64-linux.devbox = nix2containerPkgs.nix2container.buildImage {
        name = "acadx0/tools";
        tag = "devcontainer-base";

        initializeNixDatabase = true;
        nixUid = l.toInt uid;
        nixGid = l.toInt gid;

        copyToRoot = [
          # (pkgs.buildEnv {
          #   name = "dotfiles";
          #   paths = [ dotfiles ];
          #   pathsToLink = [ "/root/" ];
          # })
          (pkgs.buildEnv {
            name = "root";
            paths = [
              pkgs.coreutils-full
              pkgs.fzf
              pkgs.findutils
              pkgs.gnugrep
              pkgs.gawk
              pkgs.less
              pkgs.docker-client
              pkgs.gnugrep
              pkgs.moreutils
              pkgs.cacert
              pkgs.bash
              pkgs.fd
              pkgs.glib
              pkgs.procps
              pkgs.openssl
              pkgs.sshpass
              pkgs.tmux
              pkgs.delta
              pkgs.netcat-gnu
              pkgs.deno
              pkgs.locale
              pkgs.xorg.luit
              pkgs.sudo
              # pkgs.zsh
              # pkgs.tcpdump
              # pkgs.tshark
              pkgs.systemd
              pkgs.neovim
              pkgs.ghq
              pkgs.ttyd
              pkgs.jq
              pkgs.git
              pkgs.curl
              pkgs.stow
              pkgs.dockerTools.caCertificates
              pkgs.dockerTools.usrBinEnv
              pkgs.dockerTools.binSh
              pkgs.inetutils
              pkgs.iana-etc
              pkgs.fish
              pkgs.bind
              # pkgs.caddy
              # pkgs.s3fs
              pkgs.elvish
              pkgs.vifm
              pkgs.openssh
              pkgs.ripgrep
              pkgs.glibcLocales
            ];
            pathsToLink = [ "/bin" ];
          })
          mkUser
        ];

        perms = [{
          path = mkUser;
          regex = "/home/${user}";
          mode = "0744";
          uid = l.toInt uid;
          gid = l.toInt gid;
          uname = user;
          gname = group;
        }];

        config = {
          Cmd = [ "${pkgs.bashInteractive}/bin/bash" ];
          User = "${user}";
          WorkingDir = "/home/${user}";
          Env = [
            "SSL_CERT_FILE=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
            "SYSTEM_CERTIFICATE_PATH=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
            "GIT_SSL_CAINFO=${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"
            "LOCALE_ARCHIVE=${pkgs.glibcLocales}/lib/locale/locale-archive"
            "HOME=/home/${user}"
            "NIX_PAGER=cat"
            "USER=${user}"
          ];
        };
      };
    };
}
