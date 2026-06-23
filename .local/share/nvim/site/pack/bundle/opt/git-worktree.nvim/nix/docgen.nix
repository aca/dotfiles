{pkgs, ...}:
pkgs.writeShellApplication {
  name = "docgen";
  runtimeInputs = with pkgs; [
    lemmy-help
  ];
  text = ''
    mkdir -p doc
    lemmy-help lua/git-worktree/{init,config,hooks}.lua > doc/git-worktree.txt
  '';
}
