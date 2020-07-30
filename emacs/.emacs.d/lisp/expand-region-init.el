(use-package expand-region
  :after evil
  :config
  (define-key evil-visual-state-map (kbd "v") 'er/expand-region))

(provide 'expand-region-init)
