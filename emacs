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

(setq auto-mode-alist (append '(("\\.scss$" . css-mode))
			      auto-mode-alist))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(global-set-key (kbd "C-c C-h") (lambda() (interactive) (hide-region-hide) (keyboard-quit)))
(global-set-key (kbd "C-c C-s") (lambda() (interactive) (hide-region-unhide) (keyboard-quit)))
(put 'upcase-region 'disabled nil)

(global-set-key (kbd "M-<up>") 'enlarge-window)
(global-set-key (kbd "M-<down>") 'shrink-window)
(global-set-key (kbd "M-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "M-<left>") 'shrink-window-horizontally)
(put 'downcase-region 'disabled nil)

(custom-set-variables '(coffee-tab-width 2))
