;;; setup-clojure-mode.el --- clojure-mode-settings

;;; Commentary:

;;; Code:

(add-to-list 'auto-mode-alist '("\\.boot$" . clojure-mode))
(add-to-list 'auto-mode-alist '("\\.cljs$'" . clojure-mode))
(use-package clojure-mode
  :defer t
  :config
  (progn
    (use-package clojure-mode-extra-font-locking)
    (use-package align-cljlet
      :init (bind-keys :map clojure-mode-map
                       ("C-c j a l" . align-cljlet)))
    (use-package midje-mode)
    (use-package clj-refactor
      :config (cljr-add-keybindings-with-prefix "C-c j"))
    (use-package clojure-snippets)
    (use-package inf-clojure
      :config
      (progn
        (setq inf-clojure-prompt-read-only nil)
        (setq inf-clojure-program "boot repl")

        (defun my/inf-clojure-refresh ()
          (interactive)
          (inf-clojure-eval-string
           "(require '[clojure.tools.namespace.repl :as repl])
            (apply repl/set-refresh-dirs (get-env :directories))
            (repl/refresh)"))

        (bind-keys :map inf-clojure-minor-mode-map
                   ("C-c C-x" . my/inf-clojure-refresh))))

    (defun my/clojure-mode-hook ()
      ;; (add-hook 'before-save-hook 'my/cleanup-buffer nil t)
      (clj-refactor-mode 1)
      (inf-clojure-minor-mode 1)
      (paredit-mode 1)
      (rainbow-delimiters-mode 1))

    (add-hook 'clojure-mode-hook 'my/clojure-mode-hook)))

;;; setup-clojure-mode.el ends here
