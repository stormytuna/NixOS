{...}: {
    programs.zsh = {
        enable = true;
	enableCompletion = true;
	autosuggestions.enable = true;
	syntaxHighlighting.enable = true;

	shellInit = ''
            export ZDOTDIR=$HOME/.config/zsh
	'';
    };
}
