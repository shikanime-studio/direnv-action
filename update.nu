#!/usr/bin/env nix
#! nix develop --impure --command nu

def get_flake_packages []: nothing -> list {
    nix flake show --impure --json --all-systems
    | from json
    | get packages
    | transpose system packages
    | each { |item|
        $item.packages | transpose name info | get name
    }
    | flatten
    | where $it not-in ["devenv-test", "devenv-up"]
    | uniq
    | sort
}

# Update gitignore
(
    gitnr create
        repo:github/gitignore/refs/heads/main/Nix.gitignore
        repo:shikanime/gitignore/refs/heads/main/Devenv.gitignore
        tt:jetbrains+all
        tt:linux
        tt:macos
        tt:vim
        tt:visualstudiocode
        tt:windows
    | save --force .gitignore
)
