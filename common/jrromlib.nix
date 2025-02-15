{
  importDir = directory:
    builtins.attrNames (builtins.readDir directory)
      |> map (file: builtins.toString directory + "/" + file)
      |> builtins.filter (file: (builtins.match ".*\.nix" file) != null);
}
