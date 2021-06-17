{ pkgs, config, lib, ... }:

{
  home.packages = with pkgs; [ libiconvReal pandoc ];
  home.file = {
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
