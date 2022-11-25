;; SPDX-FileCopyrightText: 2022 Hilton Chain <hako@ultrarare.space>
;;
;; SPDX-License-Identifier: GPL-3.0-or-later

(define-module (rosenthal packages dns)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix build-system copy)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (guix utils))

(define-public dnsmasq-china-list
  ;; No version.
  (let ((revision "0")
        (commit "355fd4d7b333d767c053ed7799796ecbc745a65d"))
    (package
      (name "dnsmasq-china-list")
      (version (git-version "0" revision commit))
      (source (origin
                (method git-fetch)
                (uri (git-reference
                      (url "https://github.com/felixonmars/dnsmasq-china-list")
                      (commit commit)))
                (file-name (git-file-name name version))
                (sha256
                 (base32
                  "0ch6pvivrlfqipf8yszaqj2g6yi5js027yd0w79gg8yd0jklf19x"))))
      (build-system copy-build-system)
      (arguments
       (list #:install-plan
             #~'(("." "share/dnsmasq-china-list/" #:include-regexp ("\\.conf")))
             #:phases
             #~(modify-phases %standard-phases
                 (add-before 'install 'build
                   (lambda _
                     (for-each (lambda (target)
                                 (invoke "make" target
                                         "SERVER=domestic"
                                         "SMARTDNS_SPEEDTEST_MODE=tcp:80"))
                               '("adguardhome"
                                 "bind"
                                 "coredns"
                                 "dnscrypt-proxy"
                                 "dnsforwarder6"
                                 "dnsmasq"
                                 "smartdns" "smartdns-domain-rules"
                                 "unbound")))))))
      (home-page "https://github.com/felixonmars/dnsmasq-china-list")
      (synopsis "Chinese-specific DNS server configurations")
      (description
       "Chinese-specific configuration to improve your favorite DNS server.
Best partner for chnroutes.

@itemize
@item Improve resolve speed for Chinese domains.
@item Get the best CDN node near you whenever possible, but don't compromise
foreign CDN results so you also get best CDN node for your VPN at the same
time.
@item Block ISP ads on NXDOMAIN result (like 114so).
@end itemize\n")
      (license license:wtfpl2))))
