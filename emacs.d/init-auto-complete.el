;; http://cx4a.org/software/auto-complete/manual.html

(require 'el-get-setup)

;; start with default config from auto-complete-config
(require 'auto-complete-config)
(ac-config-default)

;; Go autocompletion
(require 'go-autocomplete)

;; C and C++ auto-completion
;; (require 'auto-complete-clang-async)
;; (add-hook 'c-mode-common-hook
;; 	  '(lambda()
;; 	     (setq ac-sources (append '(ac-source-clang-async) ac-sources))
;; 	     (setq ac-clang-complete-executable
;; 						 (format "%s/%s" 
;; 										 (car (el-get-load-path 'auto-complete-clang-async))
;; 										 "clang-complete"))
;; 	     (ac-clang-launch-completion-process)))
;; (add-hook 'auto-complete-mode-hook 'ac-common-setup)


;;(require 'auto-complete)
(require 'yasnippet)
(require 'irony) ;Note: hit `C-c C-b' to open build menu

;; the ac plugin will be activated in each buffer using irony-mode
(irony-enable 'ac)             ; hit C-RET to trigger completion

(defun my-c++-hooks ()
	  "Enable the hooks in the preferred order: 'yas -> auto-complete -> irony'."
		  ;; if yas is not set before (auto-complete-mode 1), overlays may persist after
		  ;; an expansion.
		  (yas/minor-mode-on)
			  (auto-complete-mode 1)

				  ;; avoid enabling irony-mode in modes that inherits c-mode, e.g: php-mode
				  (when (member major-mode irony-known-modes)
						    (irony-mode 1)))

(add-hook 'c++-mode-hook 'my-c++-hooks)
(add-hook 'c-mode-hook 'my-c++-hooks)


;; bind toggle-key
(define-key ac-mode-map (kbd "C-c C-c") 'auto-complete)

(provide 'init-auto-complete)
