;; (add-to-list 'load-path "/home/jrw/.nix-profile/share/emacs/site-lisp/elpa/markdown-mode-2.0/")

;;(split-window-horizontally)
(setq-default ispell-program-name "aspell")

;; kill backups
(setq delete-auto-save-files t)
(setq make-backup-files nil)

;; turn on line numbers
(setq linum-format "%d ")
;;(setq linum-format "%4d \u2502 ")
(global-linum-mode t)

;; some custom keys
(global-set-key [?\C-f] 'forward-word)
(global-set-key [?\C-b] 'backward-word)
(global-set-key [?\C-d] 'dictionay-search)
(global-set-key [?\C-j] 'kill-word)
(global-set-key [?\M-g] 'goto-line)
(global-set-key [?\M-c] 'compile)
(global-set-key [f5] 'recompile-quietly)
(global-set-key [f9] 'recompile)
(global-set-key [?\C-c ?c] 'comment-region)
(global-set-key [?\C-c ?u] 'uncomment-region)

(defun recompile-quietly ()
  "Recompile without changing the window configuration."
  (interactive)
  (save-window-excursion
    (recompile)))

(require 'haskell-mode-autoloads)
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

(require 'markdown-mode)
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editting Markdown files." t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(require 'nix-mode)
(autoload 'nix-mode "nix-mode"
  "Major mode for editting Nix expressions." t)
(push '("\\.nix\\'" . nix-mode) auto-mode-alist)
(push '("\\.nix.in\\'" . nix-mode) auto-mode-alist)
