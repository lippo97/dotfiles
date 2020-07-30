(defun my-lsp-ui-doc-scroll-up ()
  "Scroll lsp ui doc frame if visible"
  (interactive)
  (when (lsp-ui-doc--frame-visible-p)
    (lsp-ui-doc--with-buffer
     (scroll-up))))

(defun my-lsp-ui-doc-scroll-down()
  "Scroll lsp ui doc frame if visible"
  (interactive)
  (when (lsp-ui-doc--frame-visible-p)
    (lsp-ui-doc--with-buffer
     (scroll-down))))

(use-package lsp-mode
  :defer t
  :config
  (setq lsp-prefer-capf t)
  (require 'general-init)
  (my-leader-def
    "df" 'lsp-ui-doc-focus-frame
    "du" 'lsp-ui-doc-unfocus-frame
    "ds" 'lsp-ui-doc-show
    "dk" 'lsp-ui-doc-hide
    )
  (define-key lsp-mode-map (kbd "M-n") 'my-lsp-ui-doc-scroll-up)
  (define-key lsp-mode-map (kbd "M-p") 'my-lsp-ui-doc-scroll-down)
  )


;; (use-package company-lsp
;;   :after lsp-mode)

(use-package lsp-ui
  :after lsp-mode
  :config
  (setq lsp-ui-doc-delay 1
        lsp-ui-doc-max-width 80
        lsp-ui-doc-position 'at-point
        lsp-ui-doc-include-signature t
        ))

(provide 'lsp-init)
