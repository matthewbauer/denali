#!/usr/bin/env sh

nix run nixpkgs.cage -c cage -d "$(nix-build installer)/bin/installer"
