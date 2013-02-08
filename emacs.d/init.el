;; setup el-get package manager
(add-to-list 'load-path "~/.emacs.d")
(require 'el-get-setup)

;; keep customization out of our init file
(when (file-exists-p "~/.emacs.d/custom.el")
	(setq custom-file "~/.emacs.d/custom.el")
	(load custom-file))

;; code asistance
(require 'init-auto-complete)

;; plugin config
(add-hook 'before-save-hook 'gofmt-before-save)

;; tunning interface
(require 'jellybeans-theme)
(require 'ergoemacs)
;; go back to the the last point we were when opening a file
(require 'saveplace)
(setq-default save-place t)
;; misc
(setq default-tab-width 2)
(defalias 'yes-or-no-p 'y-or-n-p) ; just y/n
(xterm-mouse-mode)
(mouse-wheel-mode t)
