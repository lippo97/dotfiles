(defun my-evil-config ()
  (dolist (p '((minibuffer-inactive-mode . emacs)
               (calendar-mode . emacs)
               (special-mode . emacs)
               (grep-mode . emacs)
               (Info-mode . emacs)
               (term-mode . emacs)
               (log-edit-mode . emacs)
               (vc-log-edit-mode . emacs)
               (magit-log-edit-mode . emacs)
               (neotree-mode . emacs)
               (w3m-mode . emacs)
               (help-mode . emacs)
               (eshell-mode . emacs)
               (shell-mode . emacs)
               (epa-key-list-mode . emacs)
               (fundamental-mode . normal)
               (dired-mode . emacs)
               (compilation-mode . emacs)
               (ivy-occur-mode . emacs)
               (ffip-file-mode . emacs)
               (ivy-occur-grep-mode . normal)
               (messages-buffer-mode . normal)
               (sbt-mode . emacs)))
    (evil-set-initial-state (car p) (cdr p)))

  (evil-define-key '(normal visual insert) emacs-lisp-mode-map
    (kbd "M-l") 'paredit-forward-slurp-sexp
    (kbd "M-h") 'paredit-forward-barf-sexp)
  (evil-define-key 'normal emacs-lisp-mode-map
    "D" 'paredit-kill)

  (evil-declare-key 'normal org-mode-map
    "gh" 'outline-up-heading
    "gl" 'outline-next-visible-heading
    "gp" 'org-previous-visible-heading
    "gn" 'org-next-visible-heading
    "gN" 'org-forward-element
    "gP" 'org-backward-element
    "$" 'org-end-of-line ; smarter behaviour on headlines etc.
    "^" 'org-beginning-of-line ; ditto
    "0" 'org-beginning-of-line ; ditto
    (kbd "TAB") 'org-cycle)
  (evil-declare-key '(normal insert visual) org-mode-map
    (kbd "M-h") 'org-metaleft
    (kbd "M-l") 'org-metaright
    (kbd "M-j") 'org-metadown
    (kbd "M-k") 'org-metaup)

  (define-key evil-visual-state-map (kbd "TAB") 'indent-region)

  (define-key evil-ex-completion-map (kbd "C-a") 'move-beginning-of-line)
  (define-key evil-ex-completion-map (kbd "C-b") 'backward-char)
  (define-key evil-ex-completion-map (kbd "M-p") 'previous-complete-history-element)
  (define-key evil-ex-completion-map (kbd "M-n") 'next-complete-history-element)

  (define-key evil-normal-state-map "Y" (kbd "y$"))
  (define-key evil-normal-state-map "gd" 'xref-find-definitions)

  (with-eval-after-load 'evil
    (define-key evil-normal-state-map (kbd "M-.") 'xref-find-definitions)
    (setq evil-kill-on-visual-paste nil)
    (setq evil-default-cursor t))

  (evil-mode t))

(use-package evil
  :init
  (setq evil-move-cursor-back t
        evil-want-C-u-scroll t)
  :config
  (my-evil-config))

(use-package evil-escape
  :after evil
  :diminish
  :config (setq-default evil-escape-delay 0.3)
  (setq evil-escape-excluded-major-modes '(dired-mode
                                           magit-status-mode
                                           eshell-mode))
  (setq-default evil-escape-key-sequence "jk")
  ;; Limit the escape sequence usage to the insert mode
  (defun my-evil-is-not-insert ()
    (not (string= "insert" evil-state)))
  (setq evil-escape-inhibit-functions '(my-evil-is-not-insert))
  (evil-escape-mode 1))

(use-package evil-snipe
  :after evil
  :hook (evil-local-mode . evil-snipe-local-mode)
  :hook (evil-snipe-local-mode . evil-snipe-override-local-mode)
  :diminish evil-snipe-local-mode
  :diminish evil-snipe-override-local-mode
  :config
  (setq evil-snipe-scope 'buffer
        evil-snipe-smart-case t))

(use-package evil-surround
  :diminish
  :hook (evil-local-mode . evil-surround-mode)
  ;; :config (global-evil-surround-mode t)
  )

(use-package undo-tree
  :ensure nil
  :diminish)

(provide 'evil-init)
