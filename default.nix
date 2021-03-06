let
  nixpkgs = import "${overlay}/nixpkgs.nix";
  overlay = builtins.fetchGit {
    url = "ssh://git@github.com:/serokell/serokell-ops.git";
    rev = "e6e22f100da2834685246127e064dfa5a321c9df";
  };
in

with nixpkgs;

buildStack {
  package = "disciplina";
  src = lib.cleanSource ./.;

  overrides = final: previous: {
    rocksdb-haskell = dependCabal previous.rocksdb-haskell [ rocksdb ];
  };
}
