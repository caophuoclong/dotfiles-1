vim.cmd "packadd packer.nvim"

return require("packer").startup(
    function()
        -- Packer can manage itself
        use {"wbthomason/packer.nvim"}
        use {"kyazdani42/nvim-web-devicons"}

        -- UI (Color, statusline, dashboard...)
        use {"EdenEast/nightfox.nvim"}
        use {
            "glepnir/galaxyline.nvim",
            branch = "main",
            requires = {"kyazdani42/nvim-web-devicons"}
        }
        use {"glepnir/dashboard-nvim"}
        use {"akinsho/bufferline.nvim", requires = {"kyazdani42/nvim-web-devicons"}}

        -- Coding utilities
        use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
        use "terrortylor/nvim-comment"
        use {
            "kyazdani42/nvim-tree.lua",
            requires = {"kyazdani42/nvim-web-devicons"}
        }
        use {
            "nvim-telescope/telescope.nvim",
            requires = {"nvim-lua/plenary.nvim"}
        }
        use {"blackCauldron7/surround.nvim"}
        use {"lukas-reineke/indent-blankline.nvim"}
        use {"akinsho/toggleterm.nvim"}
        use {"windwp/nvim-autopairs"}
        use {"norcalli/nvim-colorizer.lua"}
        use {"karb94/neoscroll.nvim"}

        -- LSP
        use {"neovim/nvim-lspconfig"}
        use {"folke/lsp-colors.nvim"}
        use {"glepnir/lspsaga.nvim"}
        use {"hrsh7th/cmp-nvim-lsp"}
        use {"hrsh7th/cmp-buffer"}
        use {"tzachar/cmp-tabnine", run = "./install.sh", requires = "hrsh7th/nvim-cmp"}
        use {"hrsh7th/nvim-cmp"}
        use {"onsails/lspkind-nvim"}
        use {"L3MON4D3/LuaSnip"}
        use {"saadparwaiz1/cmp_luasnip"}
        use {"folke/trouble.nvim"}
        use {"sbdchd/neoformat"}
        use {"ray-x/lsp_signature.nvim"}
        use {"liuchengxu/vista.vim"}
        use {"simrat39/symbols-outline.nvim"}
        use {"ellisonleao/glow.nvim"}
        use {"ahmedkhalf/project.nvim"}
        use {"christoomey/vim-tmux-navigator"}

        -- Git
        use {
            "lewis6991/gitsigns.nvim",
            requires = {
                "nvim-lua/plenary.nvim"
            }
            -- tag = 'release' -- To use the latest release
        }
    end
)
