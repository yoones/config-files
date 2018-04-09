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

(setq auto-mode-alist (append '(("\\.jsx$" . jsx-mode))
			      auto-mode-alist))

(setq auto-mode-alist (append '(("\\.html.erb$" . web-mode))
			      auto-mode-alist))

(setq web-mode-markup-indent-offset 2)
(setq web-mode-code-indent-offset 2)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Hide and show blocks of text
(global-set-key (kbd "C-c C-h") (lambda() (interactive) (hide-region-hide) (keyboard-quit)))
(global-set-key (kbd "C-c C-s") (lambda() (interactive) (hide-region-unhide) (keyboard-quit)))
(put 'upcase-region 'disabled nil)

;; Resize buffers with keyboard arrows
(global-set-key (kbd "M-<up>") 'enlarge-window)
(global-set-key (kbd "M-<down>") 'shrink-window)
(global-set-key (kbd "M-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "M-<left>") 'shrink-window-horizontally)
(put 'downcase-region 'disabled nil)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(coffee-tab-width 2)
 '(custom-safe-themes
   (quote
    ("28ec8ccf6190f6a73812df9bc91df54ce1d6132f18b4c8fcc85d45298569eb53" default))))

(setq js-indent-level 2)

;; Don't break hard links (for docker)
(setq backup-by-copying t)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(package-initialize)
(load-theme 'afternoon t)

(defun cmd ()
  "Asks for a command and executes it in inferior shell with current buffer as input."
  (interactive)
  (shell-command-on-region
   (point-min) (point-max)
   (read-shell-command "$ ")))

(setq column-number-mode t)
