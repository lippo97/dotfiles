(defun my-doom-mode-hook ()
  ;; Define your custom doom-modeline
  (doom-modeline-def-modeline 'my-simple-line
    '(bar modals matches buffer-info lsp)
    '(workspace-name checker vcs major-mode repl process))

  ;; Add to `doom-modeline-mode-hook` or other hooks
  (defun setup-custom-doom-modeline ()
    (doom-modeline-set-modeline 'my-simple-line 'default))
  (add-hook 'doom-modeline-mode-hook 'setup-custom-doom-modeline))

(use-package doom-modeline
  :config (my-doom-mode-hook)
  (doom-modeline-mode 1)
  )

(provide 'modeline-init)
