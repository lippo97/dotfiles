;;; package --- Summary:
;;; Commentary:
(require 'org)
;;; Code:
(setq vc-follow-symlinks nil)
(org-babel-load-file (expand-file-name "settings.org" user-emacs-directory))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (dap-mode posframe company-lsp lsp-ui lsp-mode sbt-mode scala-mode tide js2-mode dante company-jedi rainbow-delimiters paredit flycheck company yasnippet ivy-hydra dashboard expand-region org-noter pdf-tools org-journal org-bullets magit counsel-projectile projectile diminish which-key modus-vivendi-theme modus-operandi-theme exec-path-from-shell use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
