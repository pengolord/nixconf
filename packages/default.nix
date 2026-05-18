{
  inputs,
  system,
  ...
} @ args:
{
  agenix = inputs.agenix.packages.${system}.default;
  neovim = import ./neovim args;
}
// import ./wrapped args
