(deftheme jellybeans
  "Created 2013-01-29.")

(custom-theme-set-faces
 'jellybeans
 '(default ((t (:family "default" :foundry "default" :width normal :height 1 :weight normal :slant normal :underline nil :overline nil :strike-through nil :box nil :inverse-video nil :foreground "#e8e8d3" :background "#151515" :stipple nil :inherit nil))))
 '(cursor ((t (:background "#b0d0f0"))))
 '(fixed-pitch ((t (:family "Monospace"))))
 '(variable-pitch ((t (:family "Sans Serif"))))
 '(highlight ((t (:underline t :foreground "#e1e1e0" :background "#404040"))))
 '(trailing-whitespace ((t (:background "#cf644c"))))
 '(font-lock-builtin-face ((t (:foreground "#7696d6"))))
 '(font-lock-comment-delimiter-face ((t (:foreground "#888888" :inherit (font-lock-comment-face)))))
 '(font-lock-comment-face ((t (:foreground "#888888"))))
 '(font-lock-constant-face ((t (:foreground "#cf6a4c"))))
 '(font-lock-function-name-face ((t (:weight normal :foreground "#fad07a"))))
 '(font-lock-keyword-face ((t (:foreground "#8197bf" :weight normal))))
 '(font-lock-negation-char-face ((t nil)))
 '(font-lock-preprocessor-face ((t (:foreground "#8fbfdc" :inherit (font-lock-builtin-face)))))
 '(font-lock-string-face ((t (:foreground "#99ad6a"))))
 '(font-lock-type-face ((t (:weight normal :foreground "#ffb964"))))
 '(font-lock-variable-name-face ((t (:foreground "#c6b6fe"))))
 '(font-lock-warning-face ((t (:weight bold :foreground "#902020" :inherit (error))))))

(provide-theme 'jellybeans)
