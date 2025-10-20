# Setup Direnv GitHub Action

Sets up `direnv` with your Nix flake and exports variables from `.envrc` into
`GITHUB_ENV` for subsequent workflow steps. Requires Nix installed on the runner
(e.g., Determinate Systems installer).

## Requirements

- Nix installed on the runner (e.g., Determinate Systems installer).

## Inputs

- `flake-url` (default `.`): Nix flake URL or path used by `nix develop`.
- `extra-args` (default `""`): Extra flags for `nix develop` (e.g., `--accept-flake-config`).

## Usage

```yaml
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v5
      - uses: DeterminateSystems/nix-installer-action@v19
      - uses: DeterminateSystems/magic-nix-cache-action@v13

      - name: Setup direnv environment
        uses: shikanime-studio/setup-direnv-action@v1
        with:
          flake-url: nixpkgs#direnv
          extra-args: --accept-flake-config

      - name: Use exported environment
        run: |
          echo "MY_ENV_VAR: $MY_ENV_VAR"
```
