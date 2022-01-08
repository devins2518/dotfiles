{ helix, fetchFromGitHub, unstableGitUpdater, lib, ... }:

(helix.overrideAttrs (old: rec {
  src = fetchFromGitHub {
    owner = "helix-editor";
    repo = old.pname;
    rev = "f2c73d156757b2567f306dcca4b94cf01b172d38";
    sha256 = "sha256-K+t9pV8KHK5+JdQd3M6wd86GeaLrO7q1MFUul0RE7sQ=";
    fetchSubmodules = true;
  };

  cargoDeps = old.cargoDeps.overrideAttrs (_: {
    inherit src;
    outputHash = "sha256-QAfdNd5iH4iZwzQIghzyTDilJmf9/VUyXMCQtz/fb/A=";
  });

  passthru.updateScript =
    unstableGitUpdater { url = "https://github.com/helix-editor/helix.git"; };
}))
