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

;; keep vi's home row
(global-set-key (kbd "M-j") 'next-line)
(global-set-key (kbd "M-k") 'previous-line)
(global-set-key (kbd "M-l") 'forward-char)
(global-set-key (kbd "M-h") 'backward-char)

;; use ibuffer instead of the default (C-x C-b)
(defalias 'list-buffers 'ibuffer)
;; nicer buffer switching for C-x b
(ido-mode 1)

(provide 'ergoemacs)
