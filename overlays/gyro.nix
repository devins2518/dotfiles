{ stdenv, fetchFromGitHub, lib }:

stdenv.mkDerivation rec {
  name = "gyro";
  version = "unstable-2021-05-30";

  src = builtins.fetchTarball {
    url =
      "https://github.com/mattnite/gyro/releases/download/0.2.3/gyro-0.2.3-linux-x86_64.tar.gz";
    sha256 = "041zpjs3gyng0j9q3s2zrw2rk92arj16vqi0f3qpmj6nap565xnl";
  };

  installPhase = ''
    mkdir -p $out/bin
    install bin/gyro $out/bin
  '';

  meta = with lib; {
    description = "A Zig package manager";
    homepage = "https://github.com/devins2518/gyro-nix";
    license = licenses.mit;
    maintainers = with maintainers; [ devins2518 ];
    platforms = platforms.linux;
  };
}
