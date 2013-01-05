;; setup el-get package manager
(add-to-list 'load-path "~/.emacs.d")
(require 'el-get-setup)
(require 'init-auto-complete)

;; some text editing settings
(setq default-tab-width 2)
(defalias 'yes-or-no-p 'y-or-n-p) ; just y/n
