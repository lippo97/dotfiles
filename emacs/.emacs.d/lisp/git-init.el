(when (executable-find "git")
  (defun my-magit-mode-hook ()
    (define-key magit-status-mode-map "J" 'magit-status-jump)
    (define-key magit-status-mode-map "j" 'magit-section-forward)
    (define-key magit-status-mode-map "k" 'magit-section-backward)
    (define-key magit-status-mode-map "K" 'magit-delete-thing)
    (define-key magit-status-mode-map "N"  'magit-file-untrack))
  (use-package magit
    :defer t
    :init (global-set-key (kbd "C-x g") 'magit-status)
    :config (my-magit-mode-hook))

  (use-package diff-hl
    :config (setq diff-hl-fringe-bmp-function 'diff-hl-fringe-bmp-from-type)
    (setq diff-hl-margin-side 'left)
    (defun my-diff-hl-margin-hook ()
      (diff-hl-mode t))
    (add-hook 'prog-mode-hook 'my-diff-hl-margin-hook)
    (add-hook 'markdown-mode-hook 'my-diff-hl-margin-hook)
    (add-hook 'org-mode-hook 'my-diff-hl-margin-hook)
    (add-hook 'dired-mode-hook 'diff-hl-dired-mode)
    (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh))

  (use-package git-timemachine
    :defer t
    :init
    (add-hook 'git-timemachine-mode-hook #'evil-normalize-keymaps)
    :config
    (evil-make-overriding-map git-timemachine-mode-map 'normal)
    ))


(provide 'git-init)
