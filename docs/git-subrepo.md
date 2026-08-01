# Checking git-subrepo status

This repo vendors nvim plugins (and friends) with [git-subrepo](https://github.com/ingydotnet/git-subrepo),
not submodules. There must be no gitlinks in the index:

```sh
git ls-files -s | awk '$1 == 160000'   # must print nothing
```

## Basic status

```sh
git subrepo status --quiet     # list all subrepo paths
git subrepo status <subdir>    # remote URL, tracking branch, pulled commit, pull parent
git subrepo status -F <subdir> # also fetch upstream to see if we are behind
```

`status` has no "clean/dirty" verdict; it only reports the `.gitrepo` metadata.

## Purity check (is every subrepo pristine?)

A subrepo is *pure* when:

1. its worktree is clean (no uncommitted changes under its directory), and
2. no local commits touched it since its last `git subrepo pull`
   (the only commit after `subrepo.parent` should be the pull commit itself).

Check all subrepos:

```sh
for d in $(git subrepo status --quiet); do
  dirty=$(git status --porcelain -- "$d" | wc -l)
  parent=$(git config --file "$d/.gitrepo" subrepo.parent 2>/dev/null)
  [ -z "$parent" ] && { echo "NO-GITREPO $d"; continue; }
  cnt=$(git rev-list --count "$parent..HEAD" -- "$d")
  [ "$dirty" -gt 0 ] && echo "DIRTY($dirty) $d"
  [ "$cnt" -gt 1 ] && echo "LOCAL-COMMITS($((cnt-1))) $d"
done
```

Interpreting the output:

- no output — everything is pure.
- `DIRTY(n)` — uncommitted worktree changes under the subrepo. Commit or
  `git checkout -- <dir>` them; `git subrepo pull` refuses to run on a dirty tree.
- `LOCAL-COMMITS(n)` — commits after the last pull touched the subrepo.
  Inspect with `git log --oneline "$(git config --file "$d/.gitrepo" subrepo.parent)..HEAD" -- "$d"`.
  Commits that only fix `.gitrepo` parents after a rebase are harmless;
  real content changes should be `git subrepo push`ed or reverted before the next pull.
- `NO-GITREPO` — the directory has no `.gitrepo` file (deleted or never a subrepo).
