(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(defalias 'melpa 'package-list-packages)

(defun nd () (interactive)
       (end-of-buffer)
       (insert (shell-command-to-string "blog-current-datetime.sh"))
       )

(defun nt () (interactive)
       (end-of-buffer)
       (insert (shell-command-to-string "blog-current-time.sh"))
       )
