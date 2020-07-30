(defun my-emacs-lisp-mode-hook ()
  "My custom Emacs Lisp initialization."
  (require 'paren)
  (show-paren-mode t)
  (setq show-paren-style 'parenthesis)
  (require 'general-init)
  (my-local-leader-def
    :keymaps 'emacs-lisp-mode-map
    "ex" 'eval-last-sexp
    "er" 'eval-region
    "eb" 'eval-buffer
    "fb" 'elisp-format-buffer
    "fd" 'elisp-format-directory
    "ff" 'elisp-format-file
    "fr" 'elisp-format-region
    ))
(use-package paredit
  :defer t
  :diminish
  :hook (emacs-lisp-mode . paredit-mode))

(use-package rainbow-delimiters
  :defer t
  :diminish
  :hook (emacs-lisp-mode . rainbow-delimiters-mode))

(use-package elisp-format
  :defer t)

(use-package elisp-mode
             :ensure nil
             :defer t
             :config (my-emacs-lisp-mode-hook))

(provide 'elisp-init)
