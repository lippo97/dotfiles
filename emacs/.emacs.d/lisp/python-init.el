(use-package lsp-mode
  :defer t
  :hook (python-mode . lsp))

(defvar-local python-executable-cmd "python")

(use-package pipenv
  :defer t
  :hook (python-mode . pipenv-mode)
  :init
  (defun my-pipenv-activate ()
    (interactive)
    (pipenv-activate)
    (setq python-executable-cmd (concat python-shell-virtualenv-root "/bin/python"))
    (lsp))
  :config (my-pipenv-activate)
  )

(use-package lsp-python-ms
  :defer t
  :init (setq lsp-python-ms-auto-install-server t
              lsp-python-ms-python-executable-cmd python-executable-cmd))

(provide 'python-init)
