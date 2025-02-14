# SPDX-FileCopyrightText: 2025 Matthew Mark Ibbetson
# SPDX-FileContributor: Matthew Mark Ibbetson
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  lib,
  gitSupport ? true,
  fetchFromGitHub,
  rustPlatform,
  pkg-config,
  installShellFiles,
}:

rustPlatform.buildRustPackage rec {
  pname = "litr";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "mmibbetson";
    repo = "litr";
    rev = "v${version}";
    sha256 = "sha256-D7ccY8Vq8grUwjojPzVlpBPmyU1iUwt41gYAs4rOzaI=";
  };

  cargoHash = "sha256-+QHCYQ/0Kl4cp1nyq2nCFMKNz37p8IUhq7LdF62DVRk=";

  nativeBuildInputs = [
    pkg-config
    installShellFiles
  ];
  buildInputs = [ ];

  outputs = [
    "out"
    "man"
  ];

  postInstall =
    ''
      installManPage man/litr.1 man/litr-new.1 man/litr-rename.1
      installShellCompletion \
        --bash completions/litr.bash \
        --fish completions/litr.fish \
        --zsh completions/_litr
    '';

  meta = with lib; {
    description = "A simple, minimal, and flexible command line utility for organising plaintext files.";
    homepage = "https://mmibbetson.github.io/software/litr";
    changelog = "https://github.com/mmibbetson/litr/CHANGELOG.md";
    license = licenses.gpl3Plus;
    mainProgram = "litr";
    maintainers = with maintainers; [
      mmibbetson
    ];
    platforms = platforms.unix ++ platforms.windows;
  };
}
