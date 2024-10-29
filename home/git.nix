{ pkgs, ... }:
{
  enable = true;
  userName = "Anthony";
  userEmail = "42196548+Sheeplet1@users.noreply.github.com";
  extraConfig = {
    pull.rebase = true;
    init.defaultBranch = "main";
    core = {
      longpaths = true;
      protectNTFS = false;
    };
  };
}
