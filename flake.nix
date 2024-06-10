# Do not modify! This file is generated.

{
  description = "NixOS configuration";
  inputs = {
    flakegen.url = "github:jorsn/flakegen";
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };
    # hypridle.url = "github:hyprwm/hypridle";
    # hyprland.url = "github:hyprwm/Hyprland";
    # hyprlock.url = "github:hyprwm/hyprlock";
    # hyprpaper.url = "github:hyprwm/hyprpaper";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };
  nixConfig = {
    extra-substituters = [ "https://hyprland.cachix.org" "https://nix-community.cachix.org" "https://cache.nixos.org" ];
    extra-trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
  };
  outputs = inputs: inputs.flakegen ./flake.in.nix inputs;
}
