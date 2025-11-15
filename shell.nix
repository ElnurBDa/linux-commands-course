{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  packages = with pkgs; [
    # PDF tools
    pdftk
    poppler_utils

    # Python with WeasyPrint
    (python313.withPackages (ps: [
      ps.weasyprint
    ]))
  ];

  shellHook = ''
    echo "✅ Development shell ready."
    echo "Use 'pdftk --version' to confirm it's installed."
  '';
}

