{
  description = "Luna-Nix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs, ... }@inputs: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in {

    packages.${system}.default = pkgs.stdenv.mkDerivation {
      inherit system;
      nativeBuildInputs = [
        pkgs.gnumake
        pkgs.zlib
      ];
      name = "luna";
      srcs = [ ./. ];

      buildPhase = ''
        make dist;
      '';
      
      installPhase = ''
        mkdir -p $out/bin;
        cp -r ./luna $out/bin/luna;
      '';
    };
  };
}
 
