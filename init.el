;;; init.el --- My emacs settings

;;; Commentary:

;;; Code:

;; Determine `user-emacs-directory'.
(when load-file-name
  (setq user-emacs-directory (expand-file-name
                              (file-name-directory load-file-name))))


;; Customization variables
(defgroup my/settings nil
  "My settings."
  :group 'emacs)

(defcustom my/use-ergonomic-key-bindings t
  "Non-nil to use ergonomic key bindings.  See setup-key-bindings.el.
You need to restart Emacs after changing the value."
  :group 'my/settings
  :type 'boolean)


;; Loading Cask, configuring paths...
(load (locate-user-emacs-file "bootstrap"))

;; Load modules
(require 'core-loader)

(setq my/modules (list
                  "setup-auto-complete-mode"
                  "setup-clojure-mode"
                  "setup-lisp"
                  "utils"
                  ))

(my/load-modules)



;; mozc
(when (require 'mozc nil t)
  (setq default-input-method "japanese-mozc")
  (setq mozc-candidate-style 'overlay)
  ;; faces
  (set-face-attribute 'mozc-cand-overlay-even-face 'nil
                      :background "aquamarine" :foreground "black")
  (set-face-attribute 'mozc-cand-overlay-odd-face 'nil
                      :background "aquamarine" :foreground "black"))

;; anything
;; (setq anything-c-filelist-file-name "~/project.filelist")
;; (setq anything-grep-candidates-fast-directory-regexp "^/tmp")

;; auto-complete
;; (require 'auto-complete)
;; (global-auto-complete-mode t)
;; (add-hook 'auto-complete-mode-hook
;;           (lambda ()
;;             (define-key ac-completing-map (kbd "C-n") 'ac-next)
;;             (define-key ac-completing-map (kbd "C-p") 'ac-previous)))

;; (add-to-list 'ac-modes 'coffee-mode)
;; (add-to-list 'ac-modes 'haml-mode)

;; ruby
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.jbuilder$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Guardfile$" . ruby-mode))

(require 'ruby-end)

(require 'ruby-block)

(ruby-block-mode t)
(setq ruby-block-highlight-toggle t)

;; coffee
(defun coffee-custom ()
  "coffee-mode-hook"
  (and (set (make-local-variable 'tab-width) 2)
       (set (make-local-variable 'coffee-tab-width) 2))
  )

(add-hook 'coffee-mode-hook
          '(lambda()
             (hs-minor-mode 1)
             (coffee-custom)
             (define-key coffee-mode-map (kbd "C-m") 'newline)))

;; css
(add-hook 'css-mode-hook 'ac-css-mode-setup)

;; scss
(add-hook 'scss-mode-hook 'ac-css-mode-setup)
(setq scss-compile-at-save nil)
(setq css-indent-offset 2)

;; json-mode
(add-hook 'json-mode-hook
          (lambda ()
            (setq js-indent-level 2)))
;; js2-mode
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-hook 'js2-mode-hook
          '(lambda ()
             (setq js2-basic-offset 2)
             (local-set-key "\C-ci" 'js-doc-insert-function-doc)
             (local-set-key "@" 'js-doc-insert-tag)
             ))

;; gauche
(setq process-coding-system-alist
      (cons '("gosh" utf-8 . utf-8) process-coding-system-alist))

(setq gosh-program-name "/usr/bin/gosh -i")

(autoload 'scheme-mode "cmuscheme" "Major mode for Scheme." t)
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)

(defun scheme-other-window ()
  "Run scheme on other window"
  (interactive)
  (split-window-horizontally (/ (frame-width) 2))
  (switch-to-buffer-other-window
   (get-buffer-create "*scheme*"))
  (run-scheme gosh-program-name))
(define-key global-map
  "\C-cS" 'scheme-other-window)

(put 'and-let* 'scheme-indent-function 1)
(put 'begin0 'scheme-indent-function 0)
(put 'call-with-client-socket 'scheme-indent-function 1)
(put 'call-with-input-conversion 'scheme-indent-function 1)
(put 'call-with-input-file 'scheme-indent-function 1)
(put 'call-with-input-process 'scheme-indent-function 1)
(put 'call-with-input-string 'scheme-indent-function 1)
(put 'call-with-iterator 'scheme-indent-function 1)
(put 'call-with-output-conversion 'scheme-indent-function 1)
(put 'call-with-output-file 'scheme-indent-function 1)
(put 'call-with-output-string 'scheme-indent-function 0)
(put 'call-with-temporary-file 'scheme-indent-function 1)
(put 'call-with-values 'scheme-indent-function 1)
(put 'dolist 'scheme-indent-function 1)
(put 'dotimes 'scheme-indent-function 1)
(put 'if-match 'scheme-indent-function 2)
(put 'let*-values 'scheme-indent-function 1)
(put 'let-args 'scheme-indent-function 2)
(put 'let-keywords* 'scheme-indent-function 2)
(put 'let-match 'scheme-indent-function 2)
(put 'let-optionals* 'scheme-indent-function 2)
(put 'let-syntax 'scheme-indent-function 1)
(put 'let-values 'scheme-indent-function 1)
(put 'let/cc 'scheme-indent-function 1)
(put 'let1 'scheme-indent-function 2)
(put 'letrec-syntax 'scheme-indent-function 1)
(put 'make 'scheme-indent-function 1)
(put 'multiple-value-bind 'scheme-indent-function 2)
(put 'match 'scheme-indent-function 1)
(put 'parameterize 'scheme-indent-function 1)
(put 'parse-options 'scheme-indent-function 1)
(put 'receive 'scheme-indent-function 2)
(put 'rxmatch-case 'scheme-indent-function 1)
(put 'rxmatch-cond 'scheme-indent-function 0)
(put 'rxmatch-if  'scheme-indent-function 2)
(put 'rxmatch-let 'scheme-indent-function 2)
(put 'syntax-rules 'scheme-indent-function 1)
(put 'unless 'scheme-indent-function 1)
(put 'until 'scheme-indent-function 1)
(put 'when 'scheme-indent-function 1)
(put 'while 'scheme-indent-function 1)
(put 'with-builder 'scheme-indent-function 1)
(put 'with-error-handler 'scheme-indent-function 0)
(put 'with-error-to-port 'scheme-indent-function 1)
(put 'with-input-conversion 'scheme-indent-function 1)
(put 'with-input-from-port 'scheme-indent-function 1)
(put 'with-input-from-process 'scheme-indent-function 1)
(put 'with-input-from-string 'scheme-indent-function 1)
(put 'with-iterator 'scheme-indent-function 1)
(put 'with-module 'scheme-indent-function 1)
(put 'with-output-conversion 'scheme-indent-function 1)
(put 'with-output-to-port 'scheme-indent-function 1)
(put 'with-output-to-process 'scheme-indent-function 1)
(put 'with-output-to-string 'scheme-indent-function 1)
(put 'with-port-locking 'scheme-indent-function 1)
(put 'with-string-io 'scheme-indent-function 1)
(put 'with-time-counter 'scheme-indent-function 1)
(put 'with-signal-handlers 'scheme-indent-function 1)
(put 'with-locking-mutex 'scheme-indent-function 1)
(put 'guard 'scheme-indent-function 1)

;; uniq
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward)

;; whitespace
(setq whitespace-style '(face tabs tab-mark spaces space-mark trailing space-before-tab space-after-tab::space))
(setq whitespace-space-regexp "\\(\x3000+\\)")
(setq whitespace-display-mappings
      '((space-mark ?\x3000 [?\□])
        (tab-mark   ?\t   [?\xBB ?\t])
        ))

(global-whitespace-mode t)
(set-face-attribute 'whitespace-trailing nil
                    :foreground "tomato"
                    :underline t)
(set-face-attribute 'whitespace-tab nil
                    :foreground "deep sky blue"
                    :underline t)
(set-face-attribute 'whitespace-space nil
                    :foreground "green"
                    :weight 'bold)

;; emacs style
;; history

(savehist-mode 1)

;; 起動画面を非表示
(setq inhibit-startup-message t)
;; ツールバー非表示
(tool-bar-mode -1)
;; 現在行をハイライト
(global-hl-line-mode)
;; バックアップを作成しない
(setq backup-inhibited t)
(setq delete-auto-save-files t)
;; 括弧の強調表示
(show-paren-mode t)
;; magic comment
(setq ruby-insert-encoding-magic-comment nil)
;; 括弧の自動入力
(electric-pair-mode t)
(global-font-lock-mode t)
;; 補完時に大文字小文字を区別しない
(setq completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)
;; display column number
(column-number-mode 1)
;; solarized
;; (load-theme 'solarized-light t)
(load-theme 'hc-zenburn t)
;; (load-theme 'solarized-dark t)

;; line number; tem comment
(global-linum-mode t)
(setq linum-format "%4d: ")
;; tab for space
(setq-default tab-width 2 indent-tabs-mode nil)
;; (setq-default tab-width 2 indent-tabs-mode nil)
;; fullscreen
(defun toggle-fullscreen ()
  (interactive)
  (set-frame-parameter nil 'fullscreen
                       (if (frame-parameter nil 'fullscreen)
                           nil 'fullboth)))
(global-set-key
 [f11] 'toggle-fullscreen)
;;font
(setq default-frame-alist '((font . "Inconsolata-12")))
;; (set-default-font "Inconsolata-12")
;; (set-face-font 'variable-pitch "Inconsolata-12")
;; (set-fontset-font (frame-parameter nil 'font)
;;                   'japanese-jisx0208
;;                   '("Takaoゴシック" . "unicode-bmp"))
;; inertial-scroll
(require 'inertial-scroll)
(setq inertias-global-minor-mode-map
      (inertias-define-keymap
       '(
         ("<next>"  . inertias-up)
         ("<prior>" . inertias-down)
         ("C-v"     . inertias-up)
         ("M-v"     . inertias-down)
         ) inertias-prefix-key))
(inertias-global-minor-mode 1)

;; revert-buffer
(defun revert-buffer-no-confirm ()
  "Revert buffer without confirmation."
  (interactive) (revert-buffer t t))

;; delete whitespace
(add-hook 'before-save-hook 'whitespace-cleanup)

;; display time
(setq display-time-day-and-date t)
(setq display-time-string-forms
      '((format "%s/%s(%s)%s:%s"
                month day dayname
                24-hours minutes
                )))
(display-time)

;; ediff
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq ediff-split-window-function 'split-window-horizontally)

;; git gutter
(global-git-gutter-mode +1)
;; (require 'git-gutter-fringe)
(set-face-background 'git-gutter:modified "purple")
(set-face-foreground 'git-gutter:added "green")
(set-face-foreground 'git-gutter:deleted "red")

;; e2wm
(require 'e2wm)
(global-set-key (kbd "M-+") 'e2wm:start-management)

;; (setq e2wm:c-code-recipe
;;       '(| (:left-max-size 35)
;;           (- (:upper-size-ratio 0.7)
;;              files history)
;;           (- (:upper-size-ratio 0.9)
;;              (- (:upper-size-ratio 0.9)
;;                 main repl)
;;              sub)))

(setq e2wm:c-code-winfo
      '((:name main)
        (:name files :plugin files)
        (:name history :plugin history-list)
        (:name sub :buffer "*info*" :default-hide t)
        (:name imenu :plugin imenu :default-hide t))
      )

(e2wm:add-keymap
 e2wm:pst-minor-mode-keymap
 '(("<s-left>" . e2wm:dp-code) ; codeへ変更
   ("<s-right>"  . e2wm:dp-two)  ; twoへ変更
   ("<s-up>"    . e2wm:dp-doc)  ; docへ変更
   ("<s-down>"  . e2wm:dp-dashboard) ; dashboardへ変更
   ("C-."       . e2wm:pst-history-forward-command) ; 履歴を進む
   ("C-,"       . e2wm:pst-history-back-command) ; 履歴をもどる
   ("prefix L"  . ielm)
   ("C-M-i" . e2wm:dp-code-imenu-toggle-command)
   ("M-m"       . e2wm:pst-window-select-main-command)
   ) e2wm:prefix-key)

                                        ; ag
(setq default-process-coding-system 'utf-8-unix)
(require 'ag)
(setq ag-highlight-search t)
(setq ag-reuse-buffers t)

                                        ; wgrep
(add-hook 'ag-mode-hook '(lambda ()
                           (require 'wgrep-ag)
                           (setq wgrep-auto-save-buffer t)
                           (setq wgrep-enable-key "r")
                           (wgrep-ag-setup)))

;; key config
(global-set-key (kbd "C-x b") 'anything-for-files)
(global-set-key (kbd "M-y") 'anything-show-kill-ring)
(global-set-key (kbd "C-c C-f") 'anything-filelist+)
(global-set-key (kbd "\C-h") 'delete-backward-char)
(global-set-key (kbd "\C-xrl") 'anything-bookmarks)
(global-set-key (kbd "<f5>") 'revert-buffer-no-confirm)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-x n") 'other-window)
(global-set-key (kbd "C-x p") (lambda () (interactive) (other-window -1)))
(global-set-key (kbd "C-x v =") 'git-gutter:popup-diff)
;; (global-set-key (kbd "C-@") 'anything-exuberant-ctags-select-from-here)
(global-set-key (kbd "C-;") 'highlight-symbol-at-point)
(global-set-key (kbd "C-M-;") 'highlight-symbol-remove-all)

(defun add-keys-to-ace-jump-mode (prefix c &optional mode)
  (define-key global-map
    (read-kbd-macro (concat prefix (string c)))
    `(lambda ()
       (interactive)
       (funcall (if (eq ',mode 'word)
                    #'ace-jump-word-mode
                  #'ace-jump-char-mode) ,c))))

(loop for c from ?0 to ?9 do (add-keys-to-ace-jump-mode "H-" c))
(loop for c from ?a to ?z do (add-keys-to-ace-jump-mode "H-" c))
(loop for c from ?0 to ?9 do (add-keys-to-ace-jump-mode "H-M-" c 'word))
(loop for c from ?a to ?z do (add-keys-to-ace-jump-mode "H-M-" c 'word))

(defvar ctl-q-map (make-keymap))
(define-key global-map "\C-q" ctl-q-map)

;; smartrep
(require 'smartrep)
(smartrep-define-key
    global-map "C-x" '(("p" . 'git-gutter:previous-diff)
                       ("n" . 'git-gutter:next-diff)
                       ("o" . 'other-window)))
(smartrep-define-key
    global-map "C-q" '(("n" . (lambda () (scroll-other-window 1)))
                       ("p" . (lambda () (scroll-other-window -1)))))

(require 'yasnippet)
(yas/global-mode 1)

;; anything-exuberant-ctags
;; (setq anything-exuberant-ctags-enable-tag-file-dir-cache t)
;; (setq anything-exuberant-ctags-cache-tag-file-dir "~/tags")

;; highlight-symbol
(require 'auto-highlight-symbol)
(global-auto-highlight-symbol-mode t)
(require 'highlight-symbol)
(setq highlight-symbol-colors '("DarkOrange" "DodgerBlue1" "DeepPink1"))

;; for powerline
(require 'powerline)
(powerline-default-theme)

;; for anzu
(global-anzu-mode +1)

;; for yascroll
(global-yascroll-bar-mode 1)
(scroll-bar-mode 0)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(e2wm:face-history-list-normal ((t (:foreground "LightGoldenrod1")))))

(setq edconf-exec-path "/usr/bin/editorconfig")
