(defun my-company-mode-hook ()
  (setq company-minimum-prefix-length 2
        company-idle-delay 0.1
        company-tooltip-align-annotations t)
)

(use-package company-quickhelp
  :defer t
  :hook (company-mode . company-quickhelp-mode)
  )

(use-package company
             :defer t
             :diminish
             :hook
             (prog-mode . company-mode)
             :config (my-company-mode-hook))

(provide 'company-init)
