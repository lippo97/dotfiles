(use-package ripgrep
  :defer t)

(use-package counsel-projectile
  :after projectile
  :config
  (counsel-projectile-mode t))

(defun my-projectile-mode-hook ()
  "My VIM-like projectile-mode bindings."
  (require 'general-init)
  (my-leader-def
    "p"   '(:ignore t :which-key "Projectile")
    "pp"  'projectile-switch-project
    "pb"  'projectile-switch-to-buffer
    "pd"  'projectile-dired
    "pf"  'projectile-find-file
    "pg"  'projectile-find-file-dwim
    "pa"  'projectile-find-other-file
    "po"  'projectile-find-file-other-window
    "pv"  'projectile-vc
    "ps"  'projectile-ripgrep
    "pk"  'projectile-kill-buffers
    "pS"  'projectile-save-project-buffers
    "pre" 'projectile-run-eshell
    ))


(use-package projectile
  :defer 1
  :init (my-projectile-mode-hook)
  :config (projectile-mode t)
  ;; keep the old binding
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  )


(provide 'projectile-init)
