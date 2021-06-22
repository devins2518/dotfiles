{ pkgs, config, lib, ... }:

{
  home.packages = with pkgs; [ libiconvReal pandoc ];
  home.file = {
    "pdfs/chaaya/arm7tdmi-gba.pdf" = {
      source = pkgs.fetchurl {
        url = "https://cdn.discordapp.com/attachments/465586361731121162/743737575554023494/ARM7TDMI.pdf";
        sha256 = "sha256-JHKinY0vWA040tSXXoqv/MoDPpZgXRwgMlummyTp9IQ=";
      };
    };
    "pdfs/chaaya/arm946e-s.pdf" = {
      source = pkgs.fetchurl {
        url = "https://cdn.discordapp.com/attachments/667132407262216272/818608253927686164/ARM946E-S_Technical_Reference_Manual.pdf";
        sha256 = "sha256-+0XhOElojcuBZc3xxc4ISUkqZHEqxfCU7swjlVptBD8=";
      };
    };
    "pdfs/chaaya/arm946e-s-timing.pdf" = {
      source = pkgs.fetchurl {
        url = "https://cdn.discordapp.com/attachments/667132407262216272/818608131956408401/ARM9E-S_Technical_Reference_Manual.pdf";
        sha256 = "sha256-NstSuLL45O2PWEpS/WDtgXOhajPtzIkw5nDdErlPr20=";
      };
    };
    "pdfs/chaaya/armv5.pdf" = {
      source = pkgs.fetchurl {
        url = "https://cdn.discordapp.com/attachments/667132407262216272/733255145495986246/ARMv5TE_reference_manual.pdf";
        sha256 = "sha256-5H+UPGczaz2m2O+RocD3+pW7XnLgFAyhOSZNvrQGyGo=";
      };
    };
    # TODO: fix
    #"pdfs/chaaya/gbatek.pdf" = {
    #source = pkgs.fetchurl {
    #url =
    #"http://www.problemkaputt.de/gbatek.htm";
    #downloadToTemp = true;

    ##buildPackages = [ pkgs.iconv pkgs.pandoc ];
    ##${lib.getBin pkgs.libiconv}/bin/iconv -f ISO-8859-1 -t UTF-8//TRANSLIT $downloadedFile -o gbatek.html

    #postFetch = ''
    #${pkgs.libiconvReal}/bin/iconv -f ISO-8859-1 -t UTF-8//TRANSLIT --output=/tmp/gbatek.htm $downloadedFile 
    #${pkgs.pandoc}/bin/pandoc --pdf-engine=wkhtmltopdf -t html5 -V margin-top=1 -V margin-left=0 -V margin-right=0 -V margin-bottom=1 \
    #-V papersize=letter -s -o $out/gbatek.pdf /tmp/gbatek.htm
    #'';

    #sha256 = "sha256-/sUQhvFC12JBVfbU/AUHD2lZutGVHitIK7VnUaGsY1o=";
    #};
    #};

  };
}
