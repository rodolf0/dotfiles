;; http://ergoemacs.org/emacs/effective_emacs.html

;; mostly the same as C-x C-*
(global-set-key (kbd "M-0") 'delete-window) ; close current pane
(global-set-key (kbd "M-1") 'delete-other-windows) ; expand current pane
(global-set-key (kbd "M-2") 'split-window-horizontally) ; split pane top/bottom
(global-set-key (kbd "M-3") 'split-window-vertically) ; split pane top/bottom
(global-set-key (kbd "M-s") 'other-window) ; cursor to other pane

;; easy buffer cycling
(global-set-key (kbd "<C-prior>") 'previous-buffer) ; Ctrl+PageUp
(global-set-key (kbd "<C-next>") 'next-buffer) ; Ctrl+PageDown

(global-set-key (kbd "C-v") 'scroll-up-line)
(global-set-key (kbd "M-v") 'scroll-down-line)

;; setup mouse
(xterm-mouse-mode)
(mouse-wheel-mode t)

;; make RET indent new lines
(define-key global-map (kbd "RET") 'newline-and-indent)

;; setup indentation
(setq default-tab-width 2)


;; interface tunning
(defalias 'yes-or-no-p 'y-or-n-p) ;; just y/n
(defalias 'list-buffers 'ibuffer) ;; use ibuffer for switching (C-x C-b)
(ido-mode 1) ;; nicer buffer switching for C-x b

;; go back to the the last point we were when opening a file
(require 'saveplace)
(setq-default save-place t)

;; a port of the jellybeans theme for vim
(require 'jellybeans-theme)

;; highlight parentheses
;; (require 'highlight-parentheses)
;; (define-globalized-minor-mode global-highlight-parentheses-mode
;;   highlight-parentheses-mode
;;   (lambda ()
;;     (highlight-parentheses-mode t)))
;; (global-highlight-parentheses-mode t)
(global-rainbow-delimiters-mode)

;; auto close parenthesis
(electric-pair-mode)

(provide 'my-human-interface)
