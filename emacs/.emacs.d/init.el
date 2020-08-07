(defvar best-gc-cons-threshold
  4000000
  "Best default gc threshold value.  Should NOT be too big!")

;; disable GC during startup
(setq gc-cons-threshold most-positive-fixnum)

(setq emacs-load-start-time (current-time))

(defconst my-emacs-d (file-name-as-directory user-emacs-directory)
  "Directory of emacs.d")

(defconst my-lisp-dir (concat my-emacs-d "lisp")
  "Directory of lisp")

;; (add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(add-to-list 'load-path (expand-file-name my-lisp-dir))

(require 'package-init)
(require 'settings-init)
(require 'modeline-init)
(require 'theme-init)
(require 'import-path)
(require 'diminish-init)
(require 'which-key-init)
(require 'evil-init)
(require 'hydra-init)
(require 'general-init)
(require 'projectile-init)
(require 'company-init)
(require 'flycheck-init)
(require 'eldoc-init)
(require 'ivy-init)
(require 'whitespace-init)
(require 'nerdcommenter-init)

(require 'dired-init)
(require 'eshell-init)
(require 'all-the-icons-init)
(require 'expand-region-init)

(require 'git-init)
(require 'lsp-init)

(require 'prog-init)
(require 'org-init)
(require 'org-babel-init)
(require 'elisp-init)
(require 'scala-init)
(require 'typescript-init)
(require 'react-init)

(require 'reformatter-init)

(load (setq custom-file (expand-file-name (concat my-emacs-d "custom-set-variables.el"))) t t)

(setq gc-cons-threshold best-gc-cons-threshold)

(when (require 'time-date nil t)
  (defun display-startup-echo-area-message ()
    "")
  (message "Emacs startup time: %f seconds."
           (time-to-seconds (time-since emacs-load-start-time))))
