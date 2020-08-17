(defun my-evil-nerd-commenter-hook ()
  (require 'general-init)
  (my-leader-def
    "c" '(:ignore t :which-key "Comment stuff")
    "ci" 'evilnc-comment-or-uncomment-lines
    "cc" 'evilnc-copy-and-comment-lines
    ))

(use-package evil-nerd-commenter
  :defer t
  :init (my-evil-nerd-commenter-hook))

(provide 'nerdcommenter-init)
