# Do not modify! This file is generated.
{
  description = "NixOS configuration";
  inputs = {
    flakegen.url = "github:jorsn/flakegen";
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/release-24.05";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  nixConfig = {
    experimental-features = ["nix-command" "flakes"];
    extra-substituters = ["https://hyprland.cachix.org" "https://nix-community.cachix.org"];
    extra-trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="];
    substituters = ["https://cache.nixos.org"];
  };
  outputs = inputs: inputs.flakegen ./flake.in.nix inputs;
}
