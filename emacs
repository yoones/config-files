(require 'color-theme)
(color-theme-initialize)
(add-to-list 'load-path "~/.emacs.d/plugins/")

;; Exentions matching

(add-to-list 'auto-mode-alist '("\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\.html.erb$" . html-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; Color themes

(load "yoones-theme")
(color-theme-yoones)


;; Emacs C mode config

;; (add-hook 'before-save-hook 'whitespace-cleanup)
(line-number-mode 1)
(column-number-mode 1)
(show-paren-mode 1)

;; Arduino

(load "arduino-mode")
(put 'whitespace-cleanup 'disabled t)
