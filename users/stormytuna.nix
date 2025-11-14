{pkgs, ...}: {
  users.users.stormytuna = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # Admin
      "gamemode" # Allows use of gamemoded commands
      "foundryvtt"
    ];
    shell = pkgs.nushell; # TODO: Switch to bash? zsh?
  };

  # Remove need to type password for `sudo`
  security.sudo.extraRules = [
    {
      users = ["stormytuna"];
      commands = [
        {
          command = "ALL";
          options = ["NOPASSWD"];
        }
      ];
    }
  ];
}
