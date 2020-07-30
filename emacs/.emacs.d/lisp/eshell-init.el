(defun my-eshell-prompt-function ()
  (let* ((parent (if (projectile-project-root)
                     (file-name-directory (directory-file-name (file-name-directory
                                                                (projectile-project-root)))) ""))
         (path (eshell/pwd))
         (with-project-name (replace-regexp-in-string parent "" path))
         (with-tilde (replace-regexp-in-string "/home/filo" "~" with-project-name)))
    (concat (propertize with-tilde 'face '(font-lock-variable-name-face :weight bold))
            (propertize " λ" 'face 'font-lock-constant-face)
            " ")))

(defvar my-eshell-prompt-regexp
  "^[^λ]+ λ ")

(defun my-eshell-mode-hook ()
  (setq
   eshell-banner-message ""
   eshell-scroll-to-bottom-on-input 'all
   eshell-error-if-no-glob t
   eshell-hist-ignoredups t
   eshell-save-history-on-exit t
   eshell-prefer-lisp-functions t
   eshell-destroy-buffer-when-process-dies t
   eshell-prompt-function 'my-eshell-prompt-function
   eshell-prompt-regexp my-eshell-prompt-regexp)
  (defun eshell/ff (file)
    (find-file file))
  (defun eshell/fo (file)
    (find-file-other-window file))
  (defun eshell/clear ()
    "clear the eshell buffer."
    (interactive)
    (let ((inhibit-read-only t))
      (eshell/clear-scrollback)))
  )

(use-package company-shell
  :defer t
  :after company
  :init
  (add-to-list 'company-backends 'company-shell))

(use-package eshell
  :ensure nil
  :defer t
  :config (my-eshell-mode-hook))
(provide 'eshell-init)
