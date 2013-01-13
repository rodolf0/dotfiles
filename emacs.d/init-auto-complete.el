(require 'el-get-setup)

;; start with default config from auto-complete-config
(require 'auto-complete-config)
(ac-config-default)

;; Go autocompletion
(require 'go-autocomplete)

;; C and C++ auto-completion
(require 'auto-complete-clang-async)
(add-hook 'c-mode-common-hook
	  '(lambda()
	     (setq ac-sources (append '(ac-source-clang-async) ac-sources))
	     (setq ac-clang-complete-executable
						 (format "%s/%s" 
										 (car (el-get-load-path 'auto-complete-clang-async))
										 "clang-complete"))
	     (ac-clang-launch-completion-process)))
(add-hook 'auto-complete-mode-hook 'ac-common-setup)


(provide 'init-auto-complete)
