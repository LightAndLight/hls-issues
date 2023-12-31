{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let 
        pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
        ghcVersion = "946";
      in {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [
            vscode
            haskell.packages."ghc${ghcVersion}".ghc
            cabal-install
            (haskell-language-server.override { supportedGhcVersions = [ ghcVersion ]; })
          ];
        };
      }
    );
}
