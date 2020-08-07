(defun flycheck-list-errors-and-focus ()
  "Open a flycheck error list and select it."
  (interactive)
  (flycheck-list-errors)
  (select-window (get-buffer-window "*Flycheck errors*")))

(defhydra hydra-error-navigation ()
  "Error navigation"
  ("p" previous-error "Go to the previous error")
  ("n" next-error "Go to the next error")
  ("l" flycheck-list-errors-and-focus "Open the error list" :color blue)
  ("q" nil "Exit" :color blue)
  )
(defun my-flycheck-mode-hook ()
  (require 'general-init)
  (my-leader-def
    "cc" 'hydra-error-navigation/body
    "cp" 'hydra-error-navigation/previous-error
    "cn" 'hydra-error-navigation/next-error
    )
  (setq flycheck-check-syntax-automatically '(save mode-enable idle-change)
        flycheck-disabled-checkers '('emacs-lisp-checkdoc))
  ;; (flycheck-add-mode 'javascript-eslint 'js-mode)
  (define-key flycheck-error-list-mode-map (kbd "k") 'flycheck-error-list-previous-error)
  (define-key flycheck-error-list-mode-map (kbd "j") 'flycheck-error-list-next-error)
  (add-to-list 'display-buffer-alist `(,(rx bos "*Flycheck errors*" eos)
                                       (display-buffer-reuse-window display-buffer-in-side-window)
                                       (side            . bottom)
                                       (reusable-frames . visible)
                                       (window-height   . 0.15)))
  )
(use-package flycheck
             :hook (prog-mode . flycheck-mode)
             :config (my-flycheck-mode-hook))

(provide 'flycheck-init)
