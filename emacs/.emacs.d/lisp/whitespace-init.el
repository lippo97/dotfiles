(use-package whitespace
             :ensure nil
             :diminish
             :config (add-hook 'before-save-hook 'whitespace-cleanup))

(provide 'whitespace-init)