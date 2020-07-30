(defun my-evil-nerd-commenter-hook ()
  (require 'general-init)
  (my-leader-def
    "cl" 'evilnc-comment-or-uncomment-lines
    "cL" 'evilnc-copy-and-comment-lines
    ))

(use-package evil-nerd-commenter
  :defer t
  :init (my-evil-nerd-commenter-hook))

(provide 'nerdcommenter-init)
