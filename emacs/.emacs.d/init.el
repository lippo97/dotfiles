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
 '(column-number-mode t)
 '(global-linum-mode nil)
 '(ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-top-center)))
 '(ivy-posframe-font "Source Code Pro 13")
 '(ivy-posframe-height-alist '((t . 20)))
 '(ivy-posframe-mode t nil (ivy-posframe))
 '(ivy-posframe-parameters '((internal-border-width . 10)))
 '(ivy-posframe-width 120)
 '(package-selected-packages
   '(jest magit-popup multi-term elisp-format neotree all-the-icons-dired ivy-rich all-the-icons solaire-mode ivy-posframe diff-hl doom-themes zenburn-theme dracula-theme whole-line-or-region eyebrowse projectile-ripgrep ibuffer-vc company-fuzzy symbol-overlay js2-refactor nodejs-repl emmet-mode tagedit js2-mode npm-mode dap-mode posframe company-lsp lsp-ui lsp-mode sbt-mode scala-mode tide dante company-jedi rainbow-delimiters paredit flycheck company yasnippet ivy-hydra dashboard expand-region org-noter pdf-tools org-journal org-bullets magit counsel-projectile projectile diminish which-key modus-vivendi-theme modus-operandi-theme exec-path-from-shell use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
