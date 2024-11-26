{
  config,
  options,
  pkgs,
  lib,
  inputs,
  ...
}: {
  home.file = {
    ".local/share/nvim/site/pack/paks/start/visimp".source = pkgs.fetchFromGitHub {
      owner = "visimp";
      repo = "visimp";
      rev = "36995d2a7969b03c5688a10940201e1b3f3fcfcf"; # "v0.6.0";
      sha256 = "sha256-54/iagkJ1Bs8NuEMmvmnSjL7IfVQzlSAhCnZmYciukg="; # lib.fakeSha256;
    };
  };

  # home.packages = with pkgs; [
  #   inputs.nixpkgs-unstable.legacyPackages.x86_64-linux.jetbrains.idea-community
  # ];

  programs.neovim = {
    enable = true;
    package = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux.neovim-unwrapped;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      git
      gcc
      go
      tree-sitter
      nodejs
    ];

    extraLuaConfig = ''
      require'visimp'{
        defaults = {
          foldmethod = 'marker',
        },
        lsp = {
          nullls = {
            'formatting.stylua',
            'formatting.prettierd',
          },
        },
        rust = { lsp = 'rust_analyzer' },
        ocaml = { lsp = 'ocamllsp' },
        ltex = {},
        zen = {},
        c = { lsp = 'clangd' },
        languages = {
          'c',
          'latex',
          'lua',
          'javascript',
          'html',
          'vue',
          'kotlin',
          'css',
          'ocaml',
          'json',
          'go',
          'rust',
          'python',
        },
        diagnostics = {},
        -- lspformat = {},
        theme = {
          package = 'ellisonleao/gruvbox.nvim',
          colorscheme = 'gruvbox',
          background = 'dark',
          lualine = 'gruvbox',
          before = function()
            require('gruvbox').setup({
              contrast = 'hard',
              overrides = {
                NormalFloat = { link = 'Normal' },
              },
            })
          end,
        },
      }
    '';
  };
}
