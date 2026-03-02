{ ... }:
{
  enable = true;
  settings = {
    max-gamma = 150;
    profile = [
      {
        time = "7:30";
        identity = true;
      }
      {
        time = "18:00";
        temperature = 4000;
        # gamma = 0.8;
      }
      {
        time = "19:30";
        temperature = 3500;
      }
      {
        time = "20:00";
        temperature = 3000;
      }
    ];
  };
}
