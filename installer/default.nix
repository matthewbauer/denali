{ pkgs ? import <nixpkgs> {
  overlays = [ (self: super: {
    all-cabal-hashes = self.fetchurl {
      url = https://github.com/commercialhaskell/all-cabal-hashes/archive/03513dbe3dcdecd536e23fcf3d9251ac17be1468.tar.gz;
      sha256 = "12h8b05wcpys2czngbkkh0k7zxj95ahp6vaaf3n3xr3aa8h6c6lg";
    };
    webkitgtk = self.callPackage ./webkitgtk.nix {};
  })];
} }: let
  hspec-webdriver-src = builtins.fetchTarball {
    url = https://bitbucket.org/wuzzeb/webdriver-utils/get/a8b15525a1cceb0ddc47cfd4d7ab5a29fdbe3127.tar.gz;
    sha256 = "01h1l0jff6akh2k92nndnczqm51ypwcqajj2kv857583746mvnl7";
  };
  reflex-dom-src = builtins.fetchTarball {
    url = https://github.com/reflex-frp/reflex-dom/archive/8214a67cb07eaba31ebf382903d24cde170bc6af.tar.gz;
    sha256 = "1i8xh45xdlp84xr8jzwj82jayd9z1w2b21zv1gd500mm6mfmkl68";
  };
  jsaddle-src = builtins.fetchTarball {
    url = https://github.com/ghcjs/jsaddle/archive/0cbbfe4bc6bd9d289840f80a256926b73b7b0e91.tar.gz;
    sha256 = "1p4zbnqrizsrqk9h2vb576zk6wc8388qc040m1r8k1b48hv7vwmb";
  };
in pkgs.haskellPackages.developPackage {
  root = ./.;
  overrides = self: super: {
    bimap = self.callHackage "bimap" "0.3.3" {};
    chrome-test-utils = self.callCabal2nix "chrome-test-utils" (reflex-dom-src + "/chrome-test-utils") {};
    dependent-map = self.callHackage "dependent-map" "0.3" {};
    dependent-sum = self.callHackage "dependent-sum" "0.6.2.0" {};
    dependent-sum-template = self.callHackage "dependent-sum-template" "0.1.0.0" {};
    hspec-webdriver = self.callCabal2nix "hspec-webdriver" (hspec-webdriver-src + "/hspec-webdriver") {};
    jsaddle = self.callCabal2nix "jsaddle" (jsaddle-src + "/jsaddle") {};
    jsaddle-warp = pkgs.haskell.lib.overrideCabal (self.callCabal2nix "jsaddle-warp" (jsaddle-src + "/jsaddle-warp") { }) (drv: { testTarget = "--test-option=${drv.src}"; testSystemDepends = drv.testSystemDepends or [] ++ [ pkgs.phantomjs ]; doCheck = false; });
    jsaddle-webkit2gtk = self.callCabal2nix "jsaddle-webkit2gtk" (jsaddle-src + "/jsaddle-webkit2gtk") {};
    monoidal-containers = self.callHackage "monoidal-containers" "0.6" {};
    reflex = self.callHackage "reflex" "0.6.2.4" {};
    reflex-dom = self.callCabal2nix "reflex-dom" (reflex-dom-src + "/reflex-dom") {};
    reflex-dom-core = pkgs.haskell.lib.dontCheck (self.callCabal2nix "reflex-dom-core" (reflex-dom-src + "/reflex-dom-core") {});
    these = self.callHackage "these" "1.0.1" {};
    witherable = self.callHackage "witherable" "0.3.1" {};
  };
}
