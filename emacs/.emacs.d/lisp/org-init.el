(defvar-local org-capture-default-dir
  (file-name-as-directory (concat "~/Dropbox/" "notes/")))

(defvar-local inbox-file
  (concat org-capture-default-dir "inbox.org"))

(defvar-local todo-file
  (concat org-capture-default-dir "todo.org"))

(defvar-local recipes-file
  (concat org-capture-default-dir "recipes.org"))

(defvar-local read-later-file
  (concat org-capture-default-dir "read-later.org"))

(defvar-local emacs-file
  (concat org-capture-default-dir "emacs.org"))

(defvar-local calendar-file
  (concat org-capture-default-dir "calendar.org"))

(defun my-org-capture-setup ()
  (setq org-capture-templates
        '(
          ("r" "Read later" entry (file read-later-file)
           "* TODO %? %^G" :empty-lines 1)
          ("i" "Inbox" entry (file inbox-file)
           "* %? %^G" :empty-lines 1)
          ("t" "Task" entry (file todo-file)
           "* TODO %? %^G \n  %U" :empty-lines 1)
          ("c" "Calendar")
          ("ce" "Event or birthday" entry (file calendar-file)
           "* %? \n  %^t \n" :empty-lines 1)
          ("ca" "Appointment" entry (file calendar-file)
           "* TODO %? \n  SCHEDULED: %^t \n  ADDED: %U" :empty-lines 1)
          )))
(defun my-org-agenda-setup ()
  (setq org-agenda-files
        `(
          ,todo-file
          ,read-later-file
          ,inbox-file
          ,emacs-file
          ,calendar-file
          ))
  (evil-declare-key 'normal org-agenda-mode-map
    (kbd "j") 'org-agenda-next-line
    (kbd "k") 'org-agenda-previous-item
    (kbd "l") 'org-agenda-later
    (kbd "h") 'org-agenda-earlier)
  )

(defun my-org-setup ()
  (setq org-refile-targets
        `(
          (,todo-file :maxlevel . 1)
          (,read-later-file :maxlevel . 1)
          (,emacs-file :maxlevel . 1)
          (,recipes-file :maxlevel . 1)
          (,calendar-file :maxlevel . 1)
          ))
  )


(use-package org
  :defer t
  :config (my-org-setup))

(use-package org-capture
  :ensure nil
  :defer t
  :config (my-org-capture-setup))

(use-package org-agenda
  :ensure nil
  :defer t
  :init (progn
          (require 'general-init)
          (my-leader-def
            "o"  '(:ignore t :which-key "Org mode")
            "oa" 'org-agenda
            "oc" 'org-capture
            "ol" 'org-store-link
            "oo" 'org-open-at-point
            "oi" '((lambda () (interactive) (find-file inbox-file)) :which-key "Open inbox")
            "ow" 'org-refile
            ))
  :config (my-org-agenda-setup))

(provide 'org-init)
