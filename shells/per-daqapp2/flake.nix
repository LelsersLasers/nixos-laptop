{
  description = "Dev shell for daqapp2";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";

  outputs = { self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in {
      devShells.x86_64-linux.default = pkgs.mkShell {
        packages = with pkgs; [
          cargo
          rustfmt
          clippy
          rustc
          rust-analyzer
          systemd
          pkg-config
          wayland
          wayland-protocols
          libxkbcommon
          mesa
          libGL
          systemd
          pkg-config
        ];

        shellHook = ''
          if [ -n "$WAYLAND_DISPLAY" ]; then
            export LD_LIBRARY_PATH=${pkgs.mesa}/lib:${pkgs.libGL}/lib:${pkgs.wayland}/lib:${pkgs.libxkbcommon}/lib:$LD_LIBRARY_PATH
          fi
        '';
      };
    };
}
