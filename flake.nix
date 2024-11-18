{
  description = "C++ application with libpqxx";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      flake-parts,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ];

      perSystem =
        {
          config,
          self',
          inputs',
          pkgs,
          system,
          ...
        }:
        {
          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              clang-tools
              clang
              cmake
              pkg-config
              libpqxx
              just
            ];

            shellHook = ''
              echo "C++ Development Environment with libpqxx"
              export CPLUS_INCLUDE_PATH="${pkgs.libpqxx}/include:$CPLUS_INCLUDE_PATH"
              export LIBRARY_PATH="${pkgs.libpqxx}/lib:$LIBRARY_PATH"
            '';
          };

          packages = {
            default = pkgs.stdenv.mkDerivation {
              pname = "cpp-libpqxx-app";
              version = "0.1.0";

              src = ./.;

              nativeBuildInputs = with pkgs; [
                cmake
                pkg-config
              ];

              buildInputs = with pkgs; [
                libpqxx
              ];

              configurePhase = ''
                cmake .
              '';

              buildPhase = ''
                make
              '';

              installPhase = ''
                mkdir -p $out/bin
                cp cpp-libpqxx-app $out/bin/
              '';
            };
          };
        };
    };
}
