{buildGoModule, ...}:
buildGoModule (let
  name = "niri-ipc";
in {
  name = name;
  src = ./.;
  vendorHash = null;

  # TODO: Find a better way to change command name.
  postInstall = "mv $out/bin/local $out/bin/${name}";

  meta = {
    mainProgram = name;
  };
})
