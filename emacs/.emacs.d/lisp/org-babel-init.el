(use-package org
  :ensure nil
  :init
  (org-babel-do-load-languages 'org-babel-load-languages
                               '(
                                 (shell . t)
                                 )))

(provide 'org-babel-init)
