(defun eslint-node-modules ()
    (let* ((root (locate-dominating-file (or (buffer-file-name)
                                             default-directory) "node_modules"))
           (eslint (and root
                        (expand-file-name "node_modules/.bin/eslint" root))))
      (when (and eslint
                 (file-executable-p eslint))
        (setq-local flycheck-javascript-eslint-executable eslint
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


;; (use-package typescript-mode
;;   :defer t
;; ;;:init (add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))
;;   )

;; (defun my-web-mode-hook ()
;;   (setq web-mode-markup-indent-offset 2
;;         web-mode-attr-indent-offset 2
;;         web-mode-attr-value-indent-offset 2
;;         web-mode-css-indent-offset 2
;;         web-mode-enable-auto-quoting nil)
;;   )


(use-package web-mode
  :defer t
  :ensure tide
;;   :init (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
  :config
  (setq web-mode-markup-indent-offset 2
        web-mode-attr-indent-offset 2
        web-mode-attr-value-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-enable-auto-quoting nil)
  )


(use-package tide
  :defer t
  :init
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
    (evil-define-key 'normal tide-mode-map (kbd "M-.") 'tide-jump-to-definition)
    (evil-define-key 'normal tide-mode-map (kbd "M-?") 'tide-references)
    (tide-hl-identifier-mode t)
    )
  )

(provide 'typescript-init)
