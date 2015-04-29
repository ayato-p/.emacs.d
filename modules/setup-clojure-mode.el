;;; setup-clojure-mode.el --- clojure-mode-settings

;;; Commentary:

;;; Code:

(use-package clojure-mode
  :defer t
  :config
  (progn
    (add-to-list 'auto-mode-alist '("\\.boot$" . clojure-mode))
    (add-to-list 'auto-mode-alist '("\\.cljs$'" . clojure-mode))
    (use-package clojure-snippets)
    (use-package inf-clojure
      :config
      (setq inf-clojure-prompt-read-only nil)
      (setq inf-clojure-program "boot repl"))

    (defun my/clojure-mode-hook ()
      ;; (add-hook 'before-save-hook 'my/cleanup-buffer nil t)
      (clj-refactor-mode 1)
      (inf-clojure-minor-mode 1)
      (paredit-mode 1)
      (rainbow-delimiters-mode 1))

    (add-hook 'clojure-mode-hook 'my/clojure-mode-hook)))

;;; setup-clojure-mode.el ends here
