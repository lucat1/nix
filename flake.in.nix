let vars = import ./vars.nix; in
{
  description = "NixOS configuration";

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://cache.nixos.org"
    ];
    extra-substituters = [
      "https://hyprland.cachix.org"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixlib.url = "github:nix-community/nixpkgs.lib";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
    };

  };

  outputs = inputs@{ nixpkgs, nixos-hardware, home-manager, hyprland, ... }: {
    nixosConfigurations."${vars.hostname}" = nixpkgs.lib.nixosSystem{
      system = vars.arch;
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      specialArgs = { inherit inputs; };

      modules = [
        ./configuration.nix
          nixos-hardware.nixosModules.lenovo-yoga-7-14ARH7.amdgpu
# hyprland.homeManagerModules.default

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users."${vars.user}" = {
              imports = [
                ./home
              ];
            };
            home-manager.extraSpecialArgs = { vars = import ./vars.nix; inputs = inputs; };
          }
      ];
    };
  };
}
