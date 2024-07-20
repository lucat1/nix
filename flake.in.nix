let
  vars = import ./vars.nix;
in {
  description = "NixOS configuration";

  nixConfig = {
    experimental-features = ["nix-command" "flakes"];
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
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05"; # "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # nix-index-database = {
    #   url = "github:nix-community/nix-index-database";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # hyprland = {
    #   type = "git";
    #   url = "https://github.com/hyprwm/Hyprland";
    #   submodules = true;
    # };
  };

  outputs = inputs @ {
    nixpkgs,
    nixos-hardware,
    # nix-index-database,
    home-manager,
    # hyprland,
    ...
  }: {
    # TODO
    # homeConfigurations."${vars.user}" = let
    #   pkgs = nixpkgs.legacyPackages.${vars.arch};
    # in home-manager.lib.homeManagerConfiguration{
    #   inherit pkgs;
    #
    #   modules = [
    #     nix-index-database.hmModules.nix-index
    #   ];
    # };

    nixosConfigurations."${vars.hostname}" = nixpkgs.lib.nixosSystem {
      system = vars.arch;
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      # pkgs = import nixpkgs {
      #   system = "x86_64-linux";
      #   config.allowUnfree = true;
      # };
      specialArgs = {inherit inputs;};

      modules = [
        ./configuration.nix
        nixos-hardware.nixosModules.lenovo-yoga-7-14ARH7.amdgpu

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
          home-manager.extraSpecialArgs = {
            vars = import ./vars.nix;
            inputs = inputs;
          };
        }
      ];
    };
  };
}
