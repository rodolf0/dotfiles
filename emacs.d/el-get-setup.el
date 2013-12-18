;; el-get package manager config
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
	(with-current-buffer
			(url-retrieve-synchronously
			 "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
		(let (el-get-master-branch)
			(goto-char (point-max))
			(eval-print-last-sexp))))


(setq my-packages
			'(popup
				fuzzy
				auto-complete
				auto-complete-clang-async
				go-mode
				go-autocomplete
				irony-mode
;;        highlight-parentheses
				rainbow-delimiters))

(add-to-list 'el-get-recipe-path "~/.emacs.d/recipes")
(el-get 'sync my-packages)

(provide 'el-get-setup)
