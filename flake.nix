{
  description = "NixOS configuration";

  nixConfig = {
    experimental-features = ["nix-command" "flakes"];
    substituters = [
      "https://cache.nixos.org"
    ];
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    nix-index-database,
    ...
  }: let
    vars = import ./vars.nix;
  in {
    nixosConfigurations."${vars.hostname}" = nixpkgs.lib.nixosSystem {
      system = vars.arch;
      pkgs = nixpkgs.legacyPackages.x86_64-linux;

      modules = [
        ./machines/laptop.nix
        ./configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.users."${vars.user}" = {
            imports = [
              ./home
            ];
          };
          home-manager.sharedModules = [
            nix-index-database.hmModules.nix-index
          ];
          home-manager.extraSpecialArgs = {
            vars = vars;
            inputs = inputs;
          };
        }
      ];
    };
  };
}
