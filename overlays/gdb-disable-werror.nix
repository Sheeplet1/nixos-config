final: prev:
let
  lib = prev.lib;
in
{
  gdb = prev.gdb.overrideAttrs (old: {
    # Remove --enable-werror if present, and force --disable-werror.
    configureFlags = (lib.filter (f: f != "--enable-werror") (old.configureFlags or [ ])) ++ [
      "--disable-werror"
    ];
  });
}
