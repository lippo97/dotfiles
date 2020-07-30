(use-package typescript-mode
  :defer t
;;:init (add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))
  )

(defun my-web-mode-hook ()
  (setq web-mode-markup-indent-offset 2
        web-mode-attr-indent-offset 2
        web-mode-css-indent-offset 2))

(use-package web-mode
  :defer t
  :ensure tide
  :init (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
  :config
  (tide-mode)
  (my-web-mode-hook)
  )

(defun my/use-eslint-from-node-modules ()
    (let* ((root (locate-dominating-file (or (buffer-file-name)
                                             default-directory) "node_modules"))
           (eslint (and root
                        (expand-file-name "node_modules/.bin/eslint" root))))
      (when (and eslint
                 (file-executable-p eslint))
        (setq-local flycheck-javascript-eslint-executable eslint
                    eslint-fix-executable eslint))))

(defun my-tide-setup ()
  (interactive)
  (setq company-tooltip-align-annotations t
        flycheck-idle-change-delay 2.5
        tab-width 2
        indent-tabs-mode nil
        js-indent-level 2
        typescript-indent-level 2
        show-paren-style 'parenthesis)
  (add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  (flycheck-add-next-checker 'typescript-tide '(warning . javascript-eslint))
  (flycheck-add-next-checker 'tsx-tide '(warning . javascript-eslint))
  (evil-define-key 'normal tide-mode-map (kbd "M-.") 'tide-jump-to-definition)
  (evil-define-key 'normal tide-mode-map (kbd "M-?") 'tide-references)
  (tide-setup)
  (electric-pair-mode 1)
  (tide-hl-identifier-mode 1)
  (flycheck-mode 1))

(use-package tide
  :defer t
  :config (my-tide-setup)
  :hook '(typescript-mode web-mode))

(provide 'typescript-init)
