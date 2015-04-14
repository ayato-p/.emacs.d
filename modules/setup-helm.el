;;; setup-helm.el

(require 'helm-config)

(bind-keys ("C-x C-r" . helm-recentf))

(setq helm-quick-update t
      helm-buffers-fuzzy-matching t
      helm-ff-transformer-show-only-basename nil)

(helm-descbinds-mode 1)
