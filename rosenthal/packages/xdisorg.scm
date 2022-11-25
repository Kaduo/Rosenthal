;; SPDX-FileCopyrightText: 2022 Hilton Chain <hako@ultrarare.space>
;;
;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (rosenthal packages xdisorg)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (gnu packages xdisorg))

(define-public libdrm-2.4.114
  (let ((base libdrm))
    (package
      (inherit base)
      (name "libdrm")
      (version "2.4.114")
      (source (origin
                (method url-fetch)
                (uri (string-append "https://dri.freedesktop.org/libdrm/"
                                    "libdrm-" version ".tar.xz"))
                (sha256
                 (base32
                  "09nhk3jx3qzggl5vyii3yh4zm0npjqsbxhzvxrg2xla77a2cyj9h")))))))
