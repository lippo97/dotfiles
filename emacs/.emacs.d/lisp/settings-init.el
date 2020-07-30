(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)
(setq inhibit-startup-screen t
      inhibit-startup-echo-area-message nil)

;; Backups
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq backup-by-copying t)
(setq delete-old-versions t)
(setq kept-old-versions 5)
(setq vc-make-backup-files -1)
(setq version-control t)
(setq-default create-lockfiles nil)

;; Prevent accidental C-x C-c,
;; You won't leave emacs!
(global-set-key (kbd "C-x C-c") nil)
(define-key key-translation-map (kbd "ESC") (kbd "C-g"))

(provide 'settings-init)
