{ ... }: 
let
  browser = "google-chrome.desktop";
  editor = "code.desktop"; # VS Code for general editing
  neovim = "nvim.desktop"; # For programming
  terminal = "com.mitchellh.ghostty.desktop";
  pdfviewer = "org.kde.okular.desktop";
  imgviewer = "org.ksnip.ksnip.desktop";
  videoplayer = "mpv.desktop";
  officeWriter = "writer.desktop";
  officeCalc = "calc.desktop";
  officeImpress = "impress.desktop";
in
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # --- Web Browsing ---
      "text/html" = browser;
      "x-scheme-handler/http" = browser;
      "x-scheme-handler/https" = browser;
      "x-scheme-handler/about" = browser;
      "x-scheme-handler/unknown" = browser;

      # --- Programming (Neovim) ---
      "text/x-python" = neovim;
      "text/x-csrc" = neovim;
      "text/x-c++src" = neovim;
      "text/x-c++hdr" = neovim;
      "text/x-chdr" = neovim;
      "text/x-go" = neovim;
      "text/x-lua" = neovim;
      "text/x-rust" = neovim;
      "text/x-csharp" = neovim;
      "application/javascript" = neovim;
      "application/typescript" = neovim;

      # --- General Text & Documents ---
      "text/plain" = editor;
      "application/pdf" = pdfviewer;
      "text/markdown" = editor;

      # --- Images ---
      "image/png" = imgviewer;
      "image/jpeg" = imgviewer;
      "image/gif" = imgviewer;
      "image/webp" = imgviewer;
      "image/bmp" = imgviewer;

      # --- Video ---
      "video/mp4" = videoplayer;
      "video/mpeg" = videoplayer;
      "video/x-matroska" = videoplayer; # MKV
      "video/quicktime" = videoplayer;
      "video/webm" = videoplayer;
      "video/x-msvideo" = videoplayer; # AVI

      # --- Office ---
      # Word Processing
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = officeWriter;
      "application/msword" = officeWriter;
      "application/vnd.oasis.opendocument.text" = officeWriter;
      
      # Spreadsheets
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = officeCalc;
      "application/vnd.ms-excel" = officeCalc;
      "application/vnd.oasis.opendocument.spreadsheet" = officeCalc;

      # Presentations
      "application/vnd.openxmlformats-officedocument.presentationml.presentation" = officeImpress;
      "application/vnd.ms-powerpoint" = officeImpress;
      "application/vnd.oasis.opendocument.presentation" = officeImpress;

      # --- Terminal / Misc ---
      "x-scheme-handler/terminal" = terminal;
    };
  };
}
