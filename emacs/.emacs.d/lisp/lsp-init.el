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
  :hook (lsp . lsp-ui-mode)
  :config
  (setq lsp-enable-folding nil
        lsp-enable-snippet nil
        lsp-enable-completion-at-point nil
        lsp-auto-guess-root t
        lsp-enable-symbol-highlighting t
        lsp-prefer-capf t
        lsp-enable-xref t
        lsp-enable-on-type-formatting t
        lsp-log-io nil
        lsp-print-performance nil)
  (require 'general-init)
  (define-key lsp-mode-map (kbd "M-n") 'my-lsp-ui-doc-scroll-up)
  (define-key lsp-mode-map (kbd "M-p") 'my-lsp-ui-doc-scroll-down)
  (my-local-leader-def
    "rs" 'lsp-rename
    "hh" 'lsp-ui-doc-show
    "ca" 'lsp-execute-code-action
    "fi" 'lsp-organize-imports)
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
        lsp-ui-doc-mode -1
        lsp-ui-sideline-code-actions-prefix "> "
        )
  )

(provide 'lsp-init)
