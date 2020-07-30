(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)
  (doom-themes-org-config))

(setq default-frame-alist '((font . "Source Code Pro 13")))
(set-frame-font "Source Code Pro 13")
(provide 'theme-init)
