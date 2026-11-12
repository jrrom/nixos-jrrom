{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    _7zz
    audiowaveform
    catdoc
    dtach
    epub-thumbnailer
    ffmpegthumbnailer
    file
    gnutar
    imagemagick
    inkscape
    mediainfo
    pandoc
    pdf2svg
    poppler
    poppler-utils
    ripgrep
    trash-cli
    unzip
    vips
    vipsdisp
  ];
}
