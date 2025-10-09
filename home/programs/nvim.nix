{
  config,
  options,
  pkgs,
  lib,
  inputs,
  ...
}: {
  # home.file = {
  #   ".local/share/nvim/site/pack/paks/start/visimp".source = pkgs.fetchFromGitHub {
  #     owner = "visimp";
  #     repo = "visimp";
  #     rev = "d1b7a2509831fc08bbcd3e296c69f92e7efa8247"; # latest commit on master as of 09/10/2025
  #     sha256 = "sha256-ZPNqFJS66xYztPu/SO1PGNKiWMlNoJQXtFy2f4cheZ8="; # lib.fakeSha256;
  #   };
  # };

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
