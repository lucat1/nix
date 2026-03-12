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
      rev = "700992c7875fc95c201773b137e188ebdb1bce53"; # latest commit on master as of 12.03.2025
      sha256 = "sha256-P0ZMMQnFBoxF+LBwmgAehncnhyK9dl+iEouON5u4pG0="; # lib.fakeSha256;
    };
  };

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
      python3
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
        go = { lsp = 'gopls' },
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
