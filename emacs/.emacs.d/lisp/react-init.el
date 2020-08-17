(defcustom eslint-executable-name "eslint"
  "Eslint executable file path.")

(defun eslint-node-modules ()
    (let* ((root (locate-dominating-file (or (buffer-file-name)
                                             default-directory) "node_modules"))
           (eslint (and root
                        (expand-file-name (concat "node_modules/.bin/" eslint-executable-name) root))))
      (when (and eslint
                 (file-executable-p eslint))
        (setq-default flycheck-javascript-eslint-executable eslint
                      ;; eslintd-fix-executable eslint
                      eslint-fix-executable eslint))))

(defun tsserver-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (tsserver
          (and root
               (expand-file-name "node_modules/.bin/tsserver"
                                 root))))
    (when (and tsserver (file-executable-p tsserver))
      (setq-default tide-tsserver-executable tsserver))))


(use-package tide
  :defer t
  :init
  (require 'flycheck)
  (defun setup-tide-tsx ()
    (tide-setup)
    (setq company-tooltip-align-annotations t
          flycheck-idle-change-delay 1.5
          tab-width 2
          indent-tabs-mode nil
          js-indent-level 2
          typescript-indent-level 2
          show-paren-style 'parenthesis)
    (flycheck-add-next-checker 'typescript-tide '(warning . javascript-eslint))
    (flycheck-add-next-checker 'tsx-tide '(warning . javascript-eslint))
    (flycheck-add-next-checker 'javascript-tide '(warning . javascript-eslint))
    (define-key evil-normal-state-map (kbd "M-.") 'tide-jump-to-definition)
    ;; (evil-define-key 'normal tide-mode-map (kbd "M-.") 'tide-jump-to-definition)
    (evil-define-key 'normal tide-mode-map (kbd "M-?") 'tide-references)
    (tide-hl-identifier-mode t))
  )

(defun my-react-mode-hook ()
  (require 'eslint-fix)
  (require 'general-init)
  (my-local-leader-def
    "rs" 'tide-rename-symbol
    "rf" 'tide-rename-file
    "hh" 'tide-documentation-at-point
    "ca" 'tide-code-fix
    "ee" 'tide-error-at-point
    "fi" 'tide-organize-imports
    "fe" 'eslint-fix
    "fa" 'eslint-auto-fix)
  (setup-tide-tsx))

(use-package typescript-mode
  :defer t
  :init
  (add-hook 'typescript-mode #'tsserver-node-modules)
  (add-hook 'flycheck-mode-hook #'eslint-node-modules)
  (setq eslint-executable-name "eslint_d")
  :config
  (my-react-mode-hook))

(use-package js
  :defer t
  :init
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . js-mode))
  (add-to-list 'flycheck-checkers 'javascript-tide)
  (add-hook 'js-mode #'tsserver-node-modules)
  (add-hook 'flycheck-mode-hook #'eslint-node-modules)
  (setq flycheck-checker 'javascript-tide
        eslint-executable-name "eslint_d")
  :config
  (my-react-mode-hook)
  )

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

(define-minor-mode eslint-auto-fix
  "Toggle ESLint auto format on save."
  :lighter " [ESL]"
  :global nil)

(add-hook 'eslint-auto-fix-hook 'eslint-auto-fix--toggle-hook)
(add-hook 'js-mode-hook 'eslint-auto-fix)

(provide 'react-init)
;;; react-init.el ends here
