(defun my-edit-emacs-config ()
  (interactive)
  (find-file (concat user-emacs-directory "init.el")))

(defun my-general-setup ()
  ;; choose space as my leader key
  (defconst my-leader "<SPC>")
  ;; choose space-m as my local mode leader key
  (defconst my-local-leader "<SPC> m")
  ;; create definer
  (general-create-definer my-leader-def
    :prefix my-leader
    :states '(normal visual))
  (general-create-definer my-local-leader-def
    :prefix my-local-leader
    :states '(normal visual))
  ;; define global keybindings
  (my-leader-def
    "x" '(:ignore t :which-key "Emacs legacy controls")
    "SPC" 'counsel-M-x
    "x0" 'delete-window
    "x1" 'delete-other-windows
    "x2" 'split-window-below
    "x3" 'split-window-right
    "xf" 'find-file
    "xk" 'kill-buffer
    "xo" 'other-window
    "ff" 'find-file ;; alias
    "fo" 'find-file-other-window
    "xs" 'save-buffer
    "xS" 'save-some-buffers
    "xF" 'set-fill-column
    "dd" 'dired
    "gg" 'magit
    "ee" (lambda () (interactive) (find-file (concat user-emacs-directory "init.el")))
    )
  (my-leader-def
    "O" '(:ignore t :which-key "Compilation")
    "Oc" 'compile
    "Or" 'recompile
    )
  (my-leader-def
    "b" '(:ignore t :which-key "Buffers")
    "bk" 'kill-buffer
    "bs" 'save-buffer
    "bb" 'switch-to-buffer
    "bo" 'switch-to-buffer-other-window
    )
  (my-leader-def
    "h" '(:ignore t :which-key "Describe Emacs")
    "hf" 'describe-function
    "hv" 'describe-variable
    "hm" 'describe-mode
    "hk" 'describe-key
    "ha" 'apropos-command
    "hb" 'describe-bindings
    )
  (my-leader-def
    "v" '(:ignore t :which-key "Version control")
    "vv" 'vc-next-action
    "vn" 'diff-hl-next-hunk
    "vp" 'diff-hl-previous-hunk)
  )

(use-package general
  :init (my-general-setup))

(provide 'general-init)
