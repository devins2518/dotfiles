{ pkgs, config, lib, ... }:

{
  home.packages = with pkgs; [ libiconvReal pandoc ];
  home.file = {
    "pdfs/chaaya/arm7tdmi-gba.pdf" = {
      source = pkgs.fetchurl {
        url =
          "https://cdn.discordapp.com/attachments/465586361731121162/743737575554023494/ARM7TDMI.pdf";
        sha256 = "sha256-JHKinY0vWA040tSXXoqv/MoDPpZgXRwgMlummyTp9IQ=";
      };
    };
    "pdfs/chaaya/arm946e-s.pdf" = {
      source = pkgs.fetchurl {
        url =
          "https://cdn.discordapp.com/attachments/667132407262216272/818608253927686164/ARM946E-S_Technical_Reference_Manual.pdf";
        sha256 = "sha256-+0XhOElojcuBZc3xxc4ISUkqZHEqxfCU7swjlVptBD8=";
      };
    };
    "pdfs/chaaya/arm946e-s-timing.pdf" = {
      source = pkgs.fetchurl {
        url =
          "https://cdn.discordapp.com/attachments/667132407262216272/818608131956408401/ARM9E-S_Technical_Reference_Manual.pdf";
        sha256 = "sha256-NstSuLL45O2PWEpS/WDtgXOhajPtzIkw5nDdErlPr20=";
      };
    };
    "pdfs/maqi/rfc2821 - smtp.pdf" = {
      source = pkgs.fetchurl {
        url = "https://www.rfc-editor.org/rfc/pdfrfc/rfc2821.txt.pdf";
        sha256 = "sha256-yCMjOCASyKyXaL18FuSkShZbxUGCj6p409aQgACZWJc=";
      };
    };
    "pdfs/maqi/rfc9051 - imapv4r2.pdf" = {
      source = pkgs.fetchurl {
        url = "https://www.ietf.org/rfc/rfc9051.pdf";
        sha256 = "sha256-El1HKcrvjO/ZgOfVE//NFx6NJyrMiNSmzkfzBxqx6uE=";
      };
    };
    "pdfs/maqi/rfc2087 - imap quota.pdf" = {
      source = pkgs.fetchurl {
        url = "https://www.rfc-editor.org/rfc/pdfrfc/rfc2087.txt.pdf";
        sha256 = "sha256-Oin5K5mw7XQUV9GBdbcUS62zrRX+MKRaKNQNNlU7V8c=";
      };
    };
    "pdfs/maqi/rfc5322 - imap imf.pdf" = {
      source = pkgs.fetchurl {
        url = "https://www.rfc-editor.org/rfc/pdfrfc/rfc5322.txt.pdf";
        sha256 = "sha256-pqdmt2O1NXz0JYIDQJgCwCi7ZGn6U8ZpuUkMjWIwScs=";
      };
    };
    "pdfs/maqi/rfc2045 - imap mimep1.pdf" = {
      source = pkgs.fetchurl {
        url = "https://www.rfc-editor.org/rfc/pdfrfc/rfc2045.txt.pdf";
        sha256 = "sha256-BFCY5BN1RotHyiF92Y5fzMxJ09ynPzRiwwLknhzRH5o=";
      };
    };
    "pdfs/maqi/rfc5234 - imap syntax.pdf" = {
      source = pkgs.fetchurl {
        url = "https://www.rfc-editor.org/rfc/pdfrfc/rfc5234.txt.pdf";
        sha256 = "sha256-zsg2xDz+MvuWRgVE7Vnf1yAGjX0lZLPvnP4GWP3gN0U=";
      };
    };
    "pdfs/chaaya/armv5.pdf" = {
      source = pkgs.fetchurl {
        url =
          "https://cdn.discordapp.com/attachments/667132407262216272/733255145495986246/ARMv5TE_reference_manual.pdf";
        sha256 = "sha256-5H+UPGczaz2m2O+RocD3+pW7XnLgFAyhOSZNvrQGyGo=";
      };
    };
    "pdfs/armv8.pdf" = {
      source = pkgs.fetchurl {
        url =
          "https://documentation-service.arm.com/static/623b2de33b9f553dde8fd3b0";
        sha256 = "sha256-Yq9NL5CDR8MBi9Y1cvDOHV7fDTSrrivuPBjefJfQbkM=";
      };
    };
    "pdfs/cauemu/op-code-table.html" = {
      source = pkgs.fetchurl {
        url = "https://merryhime.github.io/gba-doc/CPU/arm-table.html";
        sha256 = "sha256-JCrxyAasW+Cwu0P3kmqW2gxoeHnGaY7tOZXHV5Ngwdc=";
      };
    };

    # TODO: fix
    #     "pdfs/chaaya/gbatek.pdf" = {
    #       source = pkgs.fetchurl {
    #         url = "http://www.problemkaputt.de/gbatek.htm";

    #         #buildPackages = [ pkgs.iconv pkgs.pandoc ];
    #         #${lib.getBin pkgs.libiconv}/bin/iconv -f ISO-8859-1 -t UTF-8//TRANSLIT $downloadedFile -o gbatek.html

    #         postFetch = ''
    #           ${pkgs.recode}/bin/recode ms-ansi..utf8 $downloadedFile
    #           ${pkgs.pandoc}/bin/pandoc --pdf-engine=wkhtmltopdf -t html5 -V margin-top=1 -V margin-left=0 -V margin-right=0 -V margin-bottom=1 -V papersize=letter -o $out -s $downloadedFile
    #         '';

    #         sha256 = "sha256-Yy8oUXU+97b35lHVS896um2PWkNKdTHnCCTDCGzbSLI=";
    #       };
    #     };

  };
}
