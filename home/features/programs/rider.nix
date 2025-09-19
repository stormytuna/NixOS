{pkgs, ...}: {
  home.packages = [pkgs.jetbrains.rider];

  home.file.".ideavimrc".text = ''
    let mapleader = " "

    set clipboard=unnamedplus,unnamed,ideaput

    " search settings
    set hlsearch   " highlight search occurences
    set ignorecase " ignore case...
    set smartcase  " ..except when we start with uppercase
    set incsearch  " show search results while typing
    set wrapscan   " wrap around to start of file at end

    set scrolloff=10

    " plugins, see https://github.com/JetBrains/ideavim/wiki/IdeaVim%20Plugins
    set argtextobj
    set functiontextobj
    set highlightedyank
    set peekaboo
    set surround
    set which-key

    " fuzzy find mappings
    map <leader>ff <action>(com.mituuz.fuzzier.Fuzzier)
    map <leader>fg <action>(com.mituuz.fuzzier.FuzzyGrepCaseInsensitive)

    " other mappings
    map <leader>r <action>(RenameElement)
    nnoremap <ESC> :noh<CR><ESC>
    map U <C-R>
  '';
}
