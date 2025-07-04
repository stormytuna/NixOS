{pkgs, ...}: {
  users.users.stormytuna = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # Admin
      "gamemode" # Lets me use gamemoded commands properly
    ];
    shell = pkgs.nushell;
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
