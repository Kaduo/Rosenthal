;; SPDX-FileCopyrightText: 2022 Hilton Chain <hako@ultrarare.space>
;;
;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (rosenthal packages bittorrent)
  #:use-module (guix build-system cmake)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (gnu packages bittorrent)
  #:use-module (gnu packages qt))

(define-public qbittorrent-enhanced-edition
  (let ((base qbittorrent))
    (package
      (inherit base)
      (name "qbittorrent-enhanced-edition")
      (version "4.4.5.10")
      (source (origin
                (method git-fetch)
                (uri (git-reference
                      (url "https://github.com/c0re100/qBittorrent-Enhanced-Edition")
                      (commit (string-append "release-" version))))
                (file-name (git-file-name name version))
                (sha256
                 (base32
                  "0n1cidcricy5crzxy69z11ngvb0hy2x14nrhj100110knlq48hny"))))
      ;; REVIEW: QT6 option only added to CMake rules at the moment.
      (build-system cmake-build-system)
      (arguments
       (list #:tests? #f                ;no tests
             #:configure-flags
             #~(list "-DQT6=ON")))
      (native-inputs
       (modify-inputs (package-native-inputs base)
         (replace "qttools" qttools)))
      (inputs
       (modify-inputs (package-inputs base)
         (replace "qtbase" qtbase)
         (replace "qtsvg-5" qtsvg)))
      (home-page "https://github.com/c0re100/qBittorrent-Enhanced-Edition")
      (description
       "qBittorrent Enhanced is a bittorrent client based on qBittorrent with
the following features:

@itemize
@item Auto Ban Xunlei, QQ, Baidu, Xfplay, DLBT and Offline downloader
@item Auto Ban Unknown Peer from China Option (Default: OFF)
@item Auto Update Public Trackers List (Default: OFF)
@item Auto Ban BitTorrent Media Player Peer Option (Default: OFF)
@item Peer whitelist/blacklist
@end itemize\n"))))
