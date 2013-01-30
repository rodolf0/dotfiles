;; el-get package manager config
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
 
(unless (require 'el-get nil t)
  (url-retrieve
   "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
   (lambda (s)
     (end-of-buffer)
     (eval-print-last-sexp))))

(setq my-packages
      '(popup fuzzy auto-complete
        auto-complete-clang-async
        go-mode go-autocomplete))

(add-to-list 'el-get-recipe-path "~/.emacs.d/recipes")
(el-get 'sync my-packages)

(provide 'el-get-setup)
