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
      rev = "cc9ffdfc6bd41eb1a8ce3c8e08c63b9b541e50c5"; # "v0.6.0";
      sha256 = "sha256-meZUTd1d5oVxKBw1hlesmDqRawayn3VTWvxtpxmjoLQ="; # lib.fakeSha256;
    };
  };

  home.packages = with pkgs; [
    inputs.nixpkgs-unstable.legacyPackages.x86_64-linux.jetbrains.idea-community
  ];

  programs.neovim = {
    enable = true;
    package = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux.neovim-unwrapped;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
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
