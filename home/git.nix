{ ... }:
{
  enable = true;
  settings = {
    user = {
      name = "Anthony";
      email = "42196548+Sheeplet1@users.noreply.github.com";
    };
    init.defaultBranch = "main";
    push.default = "tracking";
    push.autoSetupRemote = true;

    pull.rebase = true;
    branch.autosetuprebase = "always";
    color.ui = true;

    core = {
      longpaths = true;
      protectNTFS = false;
    };
  };
}
