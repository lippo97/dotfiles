(use-package vterm
  :defer t
  :init
  (require 'general-init)
  (my-leader-def
    "tt" 'vterm
    "to" 'vterm-other-window))

(provide 'vterm-init)
