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
      rev = "27f8ea0";
      sha256 = "sha256-90br1YHgEIxA6gvpfR5AV5iu37dald5Qx6srRRttV0o="; # lib.fakeSha256;
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
        ltex = {},
        zen = {},
        languages = {
          'c',
          'latex',
          'lua',
          'javascript',
          'html',
          'vue',
          'css',
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
