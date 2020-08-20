(require 'eslint-fix)
(require 'flycheck)

(defun eslint-auto-fix--eslint-fix-and-flycheck ()
  (eslint-fix)
  (flycheck-buffer))

(defun eslint-auto-fix--add-hook ()
  (add-hook 'after-save-hook 'eslint-auto-fix--eslint-fix-and-flycheck))

(defun eslint-auto-fix--remove-hook ()
  (remove-hook 'after-save-hook 'eslint-auto-fix--eslint-fix-and-flycheck))

(defun eslint-auto-fix--toggle-hook ()
  (if eslint-auto-fix
    (eslint-auto-fix--add-hook)
    (eslint-auto-fix--remove-hook)))

;;;###autoload
(define-minor-mode eslint-auto-fix
  "Toggle ESLint auto format on save."
  :lighter " [ESL]"
  :global nil)

(add-hook 'eslint-auto-fix-hook 'eslint-auto-fix--toggle-hook)

(provide 'eslint-auto-fix)
