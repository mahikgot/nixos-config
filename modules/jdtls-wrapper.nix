{ config, pkgs, lib, ... }:

let
  jdtls-wrapper = pkgs.buildGoModule rec {
    pname = "jdtls-wrapper";
    version = "25.11.1";

    src = pkgs.fetchFromGitHub {
      owner = "quantonganh";
      repo = "jdtls-wrapper";
      rev = version;
      hash = "sha256-5TOdb1TMHytyVAoD/rnY/173KZZRGJa5DA11DApTTGo=";
    };

    vendorHash = null;
    ldflags = [ "-s" "-w" ];
    nativeBuildInputs = [ pkgs.makeWrapper ];

    postInstall = ''
      wrapProgram $out/bin/jdtls-wrapper \
        --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.java-language-server ]}
    '';
  };
in {
  home.packages = [ jdtls-wrapper ];
}

