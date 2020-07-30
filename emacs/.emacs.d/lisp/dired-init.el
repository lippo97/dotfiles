(defun my-dired-mode-hook ()
  (evil-declare-key '(emacs) dired-mode-map
    (kbd "j") 'dired-next-line
    (kbd "k") 'dired-previous-line
    (kbd "/") 'evil-search-forward
    (kbd "K") 'dired-do-kill-lines)
  (define-key dired-mode-map (kbd "SPC") nil))

(use-package dired
  :ensure nil
  :defer t
  :config (my-dired-mode-hook))

;; (use-package dired-git-info
;;   :after dired
;;   :defer t
;;   :init
;;   (add-hook 'dired-after-readin-hook 'dired-git-info-auto-enable)
;;   :config
;;   (setq dgi-auto-hide-details-p nil))

(provide 'dired-init)
