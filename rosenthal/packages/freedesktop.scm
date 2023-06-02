;; SPDX-FileCopyrightText: 2022 Hilton Chain <hako@ultrarare.space>
;;
;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (rosenthal packages freedesktop)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (gnu packages check)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages python))

;; https://issues.guix.gnu.org/63847
(define-public libinput-minimal-1.23.0
  (package
    (inherit libinput-minimal)
    (name "libinput-minimal")
    (version "1.23.0")
    (source (origin
              (method git-fetch)
              (uri (git-reference
                    (url "https://gitlab.freedesktop.org/libinput/libinput.git")
                    (commit version)))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "0wnqfnxxvf9jclh64hrb0scn3s1dmwdkmqf7hp0cfmjz5n5nnv7d"))))
    (native-inputs
     (modify-inputs (package-native-inputs libinput)
       (append python-minimal-wrapper python-pytest)))))

(define-public wayland-protocols-1.31
  (let ((base wayland-protocols))
    (package
      (inherit base)
      (name "wayland-protocols")
      (version "1.31")
      (source (origin
                (method url-fetch)
                (uri (string-append
                      "https://gitlab.freedesktop.org/wayland/wayland-protocols"
                      "/-/releases/" version "/downloads/"
                      "wayland-protocols-" version ".tar.xz"))
                (sha256
                 (base32
                  "0f72359fzvh6jzri4fd79m34rwm2r55p2ryq4306wrw7xliafzx0")))))))
