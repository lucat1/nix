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
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hyprland.url = "github:hyprwm/Hyprland/main";
    # hypridle.url = "github:hyprwm/hypridle/main";
    # hyprlock.url = "github:hyprwm/hyprlock/main";
    # hyprpaper.url = "github:hyprwm/hyprpaper/main";
  };

  outputs = inputs@{ nixpkgs, nixos-hardware, home-manager, ... }: { # hyprland, hypridle, hyprlock, hyprpaper, 
    nixosConfigurations."${vars.hostname}" = nixpkgs.lib.nixosSystem{
      system = vars.arch;

      modules = [
        ./configuration.nix
        nixos-hardware.nixosModules.lenovo-yoga-7-14ARH7.amdgpu

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users."${vars.user}" = {
	    imports = [
              # hyprland.homeManagerModules.default
              # hypridle.homeManagerModules.default
              # hyprlock.homeManagerModules.default
              # hyprpaper.homeManagerModules.default
              ./home
	    ];
	  };
	  home-manager.extraSpecialArgs = { vars = import ./vars.nix; };
        }
      ];
    };
  };
}
