;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Lippo"
      user-mail-address "lippo997@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
(setq doom-font (font-spec :family "Source Code Pro" :size 15 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "sans" :size 15))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'modus-operandi)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(defvar-local org-capture-default-dir
  (file-name-as-directory (concat "~/Nextcloud/" "org-notes/")))

(defvar-local inbox-file
  (concat org-capture-default-dir "inbox.org"))

(defvar-local todo-file
  (concat org-capture-default-dir "todo.org"))

(defvar-local ideas-file
  (concat org-capture-default-dir "ideas.org"))

(defvar-local recipes-file
  (concat org-capture-default-dir "recipes.org"))

(defvar-local read-later-file
  (concat org-capture-default-dir "read-later.org"))

(defvar-local emacs-file
  (concat org-capture-default-dir "emacs.org"))

(defvar-local calendar-file
  (concat org-capture-default-dir "calendar.org"))

(defvar-local my-org-roam-directory
  (file-name-as-directory (concat "~/Nextcloud/" "org-roam/")))

(defvar-local my-org-files
  `(
    ,inbox-file
    ,todo-file
    ,ideas-file
    ,recipes-file
    ,read-later-file
    ,emacs-file
    ,calendar-file
    ))

;;; Global keybindings
(map! :leader
      "qe" 'server-edit)

(map! :map emacs-lisp-mode-map
      :in
      "M-l" 'sp-forward-slurp-sexp
      "M-h" 'sp-forward-barf-sexp)

(setq org-directory my-org-roam-directory)

(setq enable-local-variables t)

;; Makes emacsclient open files in the main workspace
(after! persp-mode
  (setq persp-emacsclient-init-frame-behaviour-override "main"))

(map! :map global-map
      "<C-return>" nil)

(map! :after ivy
      :map ivy-minibuffer-map
      "<C-return>" 'ivy-immediate-done)

(map! :after flycheck
      :n
      "C-j" 'flycheck-next-error
      "C-k" 'flycheck-previous-error
      )

(after! org-capture
  (setq org-capture-templates
        '(("r" "Read later" entry (file read-later-file)
           "* TODO %? %^G" :empty-lines 1)
          ("i" "Inbox" entry (file inbox-file)
           "* %? %^G" :empty-lines 1)
          ("e" "Emacs improvement" entry (file emacs-file)
           "* TODO %? %^G" :empty-lines 1)
          ("I" "Idea" entry (file ideas-file)
           "* %? %^G \n  %U" :empty-lines 1)
          ("ca" "Appointment" entry (file calendar-file)
           "* %? \n  %^t \n  ADDED: %U" :empty-lines 1)
          ))
  )

(after! org-agenda
  (setq org-agenda-category-icon-alist `(
                                         ("calendar" ,(concat doom-private-dir "icons/calendar.svg") nil nil :ascent center)
                                         ("todo" ,(concat doom-private-dir "icons/checklist.svg") nil nil :ascent center)
                                         )
        org-agenda-files my-org-files
        org-agenda-breadcrumbs-separator " ❱ "
        org-agenda-custom-commands '(
                                     ("o" "My Agenda"
         ((todo "TODO" (
                      (org-agenda-overriding-header " TODO:\n")
                      (org-agenda-remove-tags t)
                      (org-agenda-prefix-format "  %-2i %?-12b")
                      (org-agenda-todo-keyword-format "")))
          (agenda "" (
                      (org-agenda-time-grid '((today require-timed remove-match)
                                              (900 1100 1300 1500 1700 1900 2100)
                                              "      " "┈┈┈┈┈┈┈┈┈┈┈┈┈"))
                      (org-agenda-current-time-string "⮜┈┈┈┈┈┈┈ now")
                      (org-agenda-skip-scheduled-if-done t)
                      (org-agenda-skip-timestamp-if-done t)
                      (org-agenda-skip-deadline-if-done t)
                      (org-agenda-start-day "+0d")
                      (org-agenda-span 7)
                      (org-agenda-overriding-header " SCHEDULE:\n")
                      (org-agenda-repeating-timestamp-show-all nil)
                      (org-agenda-remove-tags t)
                      (org-agenda-prefix-format "  %-3i  %-15t %s")
                      (org-agenda-todo-keyword-format " ☐ ")
                      (org-agenda-time)
                      ))))))
  (defun my-org-agenda-mode-hook ()
    (setq line-spacing 2))
  (add-hook 'org-agenda-mode-hook 'my-org-agenda-mode-hook)
  (custom-set-faces!
    '(org-agenda-structure
      :height 140
      :underline t
      :weight semi-light)
    '((org-agenda-date-today
       org-agenda-date-weekend
       org-agenda-date)
      :weight semi-light)
    )
  )

(after! org
  (setq org-ellipsis " ⤵"
        org-refile-targets (mapcar (lambda (d) `(,d :maxlevel . 1)) my-org-files))
  (defun my/open-university-course ()
    (interactive)
    (let* (
          (university-dir (concat "~/Nextcloud/" "universita/" "5"))
          (university-files
           (seq-filter (lambda (x) (not (or
                                         (string-equal x ".")
                                         (string-equal x "..")
                                         )))
                       (directory-files university-dir)))
          (selected (completing-read "Select course:" university-files)))
      (find-file (concat (file-name-as-directory university-dir) (file-name-as-directory selected) "lezioni.org"))
    ))
  (defun my/open-university-dir ()
      (interactive)
      (find-file (concat "~/Nextcloud/" "universita/" "5"))
      )
  (defun my/find-file-in-university ()
      (interactive)
      (counsel-find-file (concat "~/Nextcloud/" "universita/" "5"))
      )
  (defun my/launch-teams ()
    (interactive)
    (let ((link (car (cdr (assoc "JOIN" (org-collect-keywords '("join")))))))
      (browse-url link)
      ))
  (map! :map org-mode-map
        :leader
        :desc "Search in university"
        "n u" #'my/find-file-in-university
        "n U" #'my/open-university-course)
  (map! :map org-mode-map
        :localleader
        :desc "Launch MS Teams"
        "u t" #'my/launch-teams
        )
)

(after! org-roam

  (setq org-roam-directory my-org-roam-directory
        org-roam-db-location "/home/filo/org-roam.db"
        org-plantuml-exec-mode 'plantuml
        )
  (add-hook 'after-init-hook 'org-roam-mode)
  (require 'org-roam-protocol))

(after! evil-snipe
  (setq evil-snipe-scope 'buffer))

(after! org
  (setq org-attach-auto-tag nil)
  (add-hook 'org-mode-hook 'auto-fill-mode))

(after! org
  (setq process-connection-type nil)
  (add-to-list 'org-file-apps '("pdf" . "evince %s"))
  )

(use-package! org-noter
  :after pdf-view
  :config
  (setq org-noter-always-create-frame nil
        org-noter-hide-other t
        org-noter-notes-window-location 'vertical-split
        org-noter-insert-note-no-questions t)
  (map! :map org-noter-doc-mode-map
        :desc "Insert new note"
        "M-i" 'org-noter-insert-note)

       
  )

(after! projectile
  (setq! projectile-create-missing-test-files t)
  (projectile-update-project-type 'sbt
                                  :test-suffix "Test"
                                  :src-dir
                                  (lambda (file-path) (projectile-complementary-dir file-path "test" "main"))
                                  :test-dir
                                  (lambda (file-path) (projectile-complementary-dir file-path "main" "test")))
  (projectile-update-project-type 'npm
                                  :related-files-fn
                                  (list
                                   (projectile-related-files-fn-test-with-suffix "ts" ".spec")
                                   (projectile-related-files-fn-test-with-suffix "ts" ".test")
                                   ))
  )

(defun my/toggle-between-implementation-and-test ()
  (interactive)
  ;; Detect wether it was called with universal argument
  (if (equal current-prefix-arg nil)
      (projectile-toggle-between-implementation-and-test)
    (projectile-find-implementation-or-test-other-window))
  )

(map! :leader
      :map projectile-mode-map
      :desc "Go to implementation/test"
      "ft" #'my/toggle-between-implementation-and-test)

(after! conda
  (setq conda-env-home-directory "/home/filo/.conda"
        conda-anaconda-home "/opt/miniconda3")
  (add-to-list 'python-shell-completion-native-disabled-interpreters "python3" )
  )

(after! projectile
  (defun my/scala-get-package-name-from-path ()
    (let* ((current-file (buffer-file-name (current-buffer)))
           (project-root (projectile-project-root))
           (source-set (cond
                        ((projectile-test-file-p current-file) "test")
                        (t "main")
                        ))
           (source-set-absolute-path (f-join project-root
                                             "src/"
                                             source-set
                                             "scala/"
                                             ))
           (current-file-directory (file-name-directory current-file))
           (package-relative-path (directory-file-name (file-relative-name current-file-directory source-set-absolute-path)))
           )
      (s-replace "/" "." package-relative-path)
      )
    )
  )

(map! :map tide-mode-map
      :n "<f2>" 'tide-rename-symbol
      :n "M-." 'tide-fix
      :n "C-." 'tide-fix
      )
(map! :map tide-mode-map
      :leader
      :n "m f" '+format/buffer
      )

(use-package! typescript-mode
  :defer nil
  :init
  (define-derived-mode typescript-tsx-mode typescript-mode "tsx")
  :config
  (setq typescript-indent-level 2
        typescript-expr-indent-offset 2)
  (add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-tsx-mode)))

(use-package! tree-sitter
  :hook ((typescript-mode . tree-sitter-hl-mode)
         (typescript-tsx-mode . tree-sitter-hl-mode))
  )

(use-package! tree-sitter-langs
  :after tree-sitter
  :config
  (tree-sitter-require 'tsx)
  (add-to-list 'tree-sitter-major-mode-language-alist '(typescript-tsx-mode . tsx)))

(set-file-template! "\\.tsx$" :mode 'typescript-tsx-mode)
(set-file-template! "\\.scala$" :mode 'scala-mode :project t)
