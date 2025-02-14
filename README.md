<!--
SPDX-FileCopyrightText: 2025 Matthew Mark Ibbetson
SPDX-FileContributor: Matthew Mark Ibbetson

SPDX-License-Identifier: GPL-3.0-or-later
-->

# litr

<!-- TODO: Summary -->

## Installation

### Cargo Install

#### Crates.io

If you have a Rust environment set up, you can install the binary from [crates.io](https://crates.io/crates/litr) with the following command:

```sh
cargo install dn-cli
```

### Build From Source

```sh
git clone https://github.com/mmibbetson/litr
cd litr
just install
```

### Nix

#### Download From Nixpkgs

In configuration.nix, you can add the package as `litr` --- for example:

```nix
  users.users.yourUsername = {
    packages = with pkgs; [
      litr
    ];
  };
```

#### Build Derivation

```sh
git clone https://github.com/mmibbetson/litr
```

You can then add the package in your configuration.nix with the following:

```nix
nixpkgs.config.packageOverrides = pkgs: {
  litr = pkgs.callPackage <route-to-dn-repository>/default.nix { };
};
```

From there you can install the package as `litr` at the system level or user level by including it in your packages.

## Quick Start

```bash
```

## Extras

Manpages and shell completions are available, they can be installed manually. The supported shells are:

- bash
- zsh
- fish
- powershell
- nushell
- elvish

## Editor Support

iu is designed with the intention that it will be integrated into text editors via extensions. When Helix's plugin system is implemented, the intention is to provide an ergonomic set of extensions as specified in the [integration docs](./docs/dev/integrations.md). A VSCode extension is also being considered.

- [ ] Helix
- [ ] Visual Studio Code

## Inspirations

- [Literate Programming]()
- [Emacs' Org Mode]()
- [The Unix Philosophy](https://en.wikipedia.org/wiki/Unix_philosophy)
- [Cold-Blooded Software](https://dubroy.com/blog/cold-blooded-software/)

## Dependencies

Dependencies are relatively minimal. In time, this project will be feature-complete, and enter maintenance mode. A primary concern for dn is to minimise churn and maximise long-term stability. Eventually, all dependencies will be vendored and the program will be considered "finished", outside of necessary bug fixes and/or emergency patches.

## Development

- litr follows [Semantic Versioning](https://semver.org/) for version numbering.
- litr uses [Conventional Commits](https://www.conventionalcommits.org/) for commit messages.
- litr is [REUSE](https://reuse.software/) compliant.
