(defun my-company-mode-hook ()
  (require 'evil)
  (setq company-minimum-prefix-length 2
        company-idle-delay 0.1
        company-tooltip-align-annotations t)
  (evil-define-key 'insert company-mode-map (kbd "TAB") 'company-complete-common)
  (define-key company-active-map (kbd "ESC") nil)
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil))


;; Disabled for now: https://github.com/company-mode/company-quickhelp/issues/17#issuecomment-526783169
;; (use-package company-quickhelp
;;   :defer t
;;   :after company
;;   :hook (company-mode . company-quickhelp-mode)
;; )

(use-package company
             :defer t
             :diminish
             :hook
             (prog-mode . company-mode)
             :config (my-company-mode-hook))

(provide 'company-init)
