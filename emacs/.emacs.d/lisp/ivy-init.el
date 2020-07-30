(use-package ivy-rich
             :after ivy)

(use-package counsel
             :after ivy
             :diminish)

(use-package ivy
             :diminish
             )

(setq ivy-use-group-face-if-no-groups t)
(ivy-mode t)
(counsel-mode t)
(ivy-rich-mode t)

(provide 'ivy-init)



