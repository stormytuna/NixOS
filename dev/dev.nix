{ pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    git
    neovim
    github-desktop
    jetbrains.rider
    avalonia-ilspy

    vscode
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        vscodevim.vim
        ms-dotnettools.csharp
      ];
    })
  ];

  programs.adb.enable = true;
}
