{pkgs, ...}: {
  users.users.stormytuna = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # Admin
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
