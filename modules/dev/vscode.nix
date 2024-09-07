{
  config,
  lib,
  pkgs,
  vscode-marketplace,
  ...
}: {
  imports = [<home-manager/nixos>];

  options = {
    modules.dev.vscode.enable = lib.mkEnableOption "Enables visual studio code and configs";
  };

  config = lib.mkIf config.modules.dev.vscode.enable {
    home-manager.users.stormytuna.programs.vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
      mutableExtensionsDir = false; # Prevents issues where extensions are not found
      extensions = with pkgs.vscode-extensions;
        [
          vscodevim.vim
          vscode-marketplace.codium.codium
          pkief.material-icon-theme
        ]
        ++ (lib.optionals config.modules.dev.csharp.enable [
          ms-dotnettools.csharp
          ms-dotnettools.csdevkit
          ms-dotnettools.vscode-dotnet-runtime
          vscode-marketplace.eservice-online.vs-sharper
        ]);
      userSettings =
        {
          "editor.formatOnPaste" = true;
          "files.insertFinalNewline" = true;
          "git.allowForcePush" = true;
          "git.branchProtectionPrompt" = "alwaysCommit";
          "git.confirmSync" = false;
          "git.enableSmartCommit" = true;
        }
        // lib.optionalAttrs config.modules.dev.csharp.enable {
          "csharp.experimental.debug.hotReload" = true;
          "csharp.inlayHints.enableInlayHintsForImplicitObjectCreation" = true;
          "csharp.inlayHints.enableInlayHintsForImplicitVariableTypes" = true;
          "csharp.inlayHints.enableInlayHintsForLambdaParameterTypes" = true;
          "dotnet.automaticallyCreateSolutionInWorkspace" = false;
          "dotnet.server.useOmnisharp" = true;
          "omnisharp.organizeImportsOnFormat" = true;
          "[csharp]"."editor.defaultFormatter" = "ms-dotnettools.csharp";
        };
    };
  };
}
