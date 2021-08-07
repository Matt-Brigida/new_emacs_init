;;;my new emacs config

;;; be able to install package from MELPA
(require 'package) ;; You might already have this line
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(package-initialize) ;; You might already have this line


;;;to use use-package-----
;; This is only needed once, near the top of the file
(eval-when-compile
;;   ;; Following line is not needed if use-package.el is in ~/.emacs.d
   (add-to-list 'load-path "~/.emacs.d/elpa/use-package-20210207.1926/")
   (require 'use-package))


;;;GENERAL CONFIG-------------

(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "<f5>") 'other-window)

(visual-line-mode 1)

(add-hook 'org-mode-hook 'visual-line-mode)

;;; turn off tool and scroll bar
(tool-bar-mode -1)

;;only do if gui
(cond
 ((window-system) (scroll-bar-mode -1))
 ((daemonp) (scroll-bar-mode -1))
 (t ))

;; Remove the menu bar
(menu-bar-mode -1)

;;; turn off alarm bell
(setq ring-bell-function 'ignore)

(load-theme 'tango-dark)

;; disable adverts
(setq inhibit-startup-screen t)

(defun display-startup-echo-area-message ()
   (message "One Editor to Rule Them All."))
  ;;  (message "Greetings Earthling."))

;;; handling backups-------
(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.emacs.d/saves/"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned ba


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-adapt-indentation nil)
 '(org-agenda-files
   '("~/1_Shared_Files/org/events.org" "~/1_Shared_Files/org/notes.org" "~/1_Shared_Files/TODO.org"))
 '(package-selected-packages
   '(doom-modeline all-the-icons doom-themes company-quickhelp hackernews ivy-bibtex biblio solarized-theme writegood-mode magit howdoyou define-word use-package bbdb company lsp-ivy counsel ivy lsp-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(ivy-mode)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;; enable this if you want `swiper' to use it
;; (setq search-default-mode #'char-fold-to-regexp)
(global-set-key "\C-s" 'swiper)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "<f6>") 'ivy-resume)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f1> f") 'counsel-describe-function)
(global-set-key (kbd "<f1> v") 'counsel-describe-variable)
(global-set-key (kbd "<f1> o") 'counsel-describe-symbol)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
(global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
(global-set-key (kbd "<f2> u") 'counsel-unicode-char)
(global-set-key (kbd "C-c g") 'counsel-git)
(global-set-key (kbd "C-c j") 'counsel-git-grep)
(global-set-key (kbd "C-c k") 'counsel-ag)
(global-set-key (kbd "C-x l") 'counsel-locate)
(global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

;;;LSP

;;;python
(require 'lsp-python-ms)
(setq lsp-python-ms-auto-install-server t)
(add-hook 'python-mode-hook #'lsp) ; or lsp-deferred
(add-hook 'c-mode-hook #'lsp)
(add-hook 'c++-mode-hook #'lsp)
(add-hook 'ess-mode-hook #'lsp)

;;; latex-----
(setq org-latex-pdf-process
      '("pdflatex -interaction nonstopmode -output-directory %o %f"
        "bibtex %b"
        "pdflatex -interaction nonstopmode -output-directory %o %f"
        "pdflatex -interaction nonstopmode -output-directory %o %f"))

(setq bibtex-completion-bibliography
      '("~/1_Shared_Files/1_WORK_COMPUTER/1_Research_wc/1_Research_Github/references.bib"))
       ;;add another like this ""))


;;; do not kill text when the mark is inactive------
(setq mark-even-if-inactive nil)

;;; org babel-------
(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (python . t)
   (C . t)
   ;;   (cpp . t)
   (js . t)
   (shell . t)
   ;;   (rust . t))
   ))

(setq org-confirm-babel-evaluate nil)

;;;Company------
;; always turn on company mode (do we want to make this more targeted?)
(global-company-mode 1)

;;; Color Theme-------
;;(load-theme 'solarized-dark t)

;;ivy-bibtex
(require 'ivy-bibtex)

;;browse urls in eww
(setq browse-url-browser-function 'eww-browse-url)

;; autocomplete file path-----
(global-set-key (kbd "M-n") 'company-files)

;; document function completions
(company-quickhelp-mode)

;;spell check text mode-----
(add-hook 'text-mode-hook 'flyspell-mode)

;;doom-themes
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  ;; (doom-themes-neotree-config)
  ;; or for treemacs users
  ;; (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  ;; (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;;all the icons
(use-package all-the-icons)

;;doom modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;; How tall the mode-line should be. It's only respected in GUI.
;; If the actual char height is larger, it respects the actual height.
(setq doom-modeline-height 25)

;; How wide the mode-line bar should be. It's only respected in GUI.
(setq doom-modeline-bar-width 4)

;; Whether to use hud instead of default bar. It's only respected in GUI.
;;(defcustom doom-modeline-hud nil)

;; The limit of the window width.
;; If `window-width' is smaller than the limit, some information won't be displayed.
(setq doom-modeline-window-width-limit fill-column)

;; How to detect the project root.
;; The default priority of detection is `ffip' > `projectile' > `project'.
;; nil means to use `default-directory'.
;; The project management packages have some issues on detecting project root.
;; e.g. `projectile' doesn't handle symlink folders well, while `project' is unable
;; to hanle sub-projects.
;; You can specify one if you encounter the issue.
;; (setq doom-modeline-project-detection 'project)

;; Determines the style used by `doom-modeline-buffer-file-name'.
;;
;; Given ~/Projects/FOSS/emacs/lisp/comint.el
;;   auto => emacs/lisp/comint.el (in a project) or comint.el
;;   truncate-upto-project => ~/P/F/emacs/lisp/comint.el
;;   truncate-from-project => ~/Projects/FOSS/emacs/l/comint.el
;;   truncate-with-project => emacs/l/comint.el
;;   truncate-except-project => ~/P/F/emacs/l/comint.el
;;   truncate-upto-root => ~/P/F/e/lisp/comint.el
;;   truncate-all => ~/P/F/e/l/comint.el
;;   truncate-nil => ~/Projects/FOSS/emacs/lisp/comint.el
;;   relative-from-project => emacs/lisp/comint.el
;;   relative-to-project => lisp/comint.el
;;   file-name => comint.el
;;   buffer-name => comint.el<2> (uniquify buffer name)
;;
;; If you are experiencing the laggy issue, especially while editing remote files
;; with tramp, please try `file-name' style.
;; Please refer to https://github.com/bbatsov/projectile/issues/657.
(setq doom-modeline-buffer-file-name-style 'auto)

;; Whether display icons in the mode-line.
;; While using the server mode in GUI, should set the value explicitly.
(setq doom-modeline-icon (display-graphic-p))

;; Whether display the icon for `major-mode'. It respects `doom-modeline-icon'.
(setq doom-modeline-major-mode-icon t)

;; Whether display the colorful icon for `major-mode'.
;; It respects `all-the-icons-color-icons'.
(setq doom-modeline-major-mode-color-icon t)

;; Whether display the icon for the buffer state. It respects `doom-modeline-icon'.
(setq doom-modeline-buffer-state-icon t)

;; Whether display the modification icon for the buffer.
;; It respects `doom-modeline-icon' and `doom-modeline-buffer-state-icon'.
(setq doom-modeline-buffer-modification-icon t)

;; Whether to use unicode as a fallback (instead of ASCII) when not using icons.
(setq doom-modeline-unicode-fallback nil)

;; Whether display the minor modes in the mode-line.
(setq doom-modeline-minor-modes nil)

;; If non-nil, a word count will be added to the selection-info modeline segment.
(setq doom-modeline-enable-word-count nil)

;; Major modes in which to display word count continuously.
;; Also applies to any derived modes. Respects `doom-modeline-enable-word-count'.
;; If it brings the sluggish issue, disable `doom-modeline-enable-word-count' or
;; remove the modes from `doom-modeline-continuous-word-count-modes'.
(setq doom-modeline-continuous-word-count-modes '(markdown-mode gfm-mode org-mode))

;; Whether display the buffer encoding.
(setq doom-modeline-buffer-encoding t)

;; Whether display the indentation information.
(setq doom-modeline-indent-info nil)

;; If non-nil, only display one number for checker information if applicable.
(setq doom-modeline-checker-simple-format t)

;; The maximum number displayed for notifications.
(setq doom-modeline-number-limit 99)

;; The maximum displayed length of the branch name of version control.
(setq doom-modeline-vcs-max-length 12)

;; Whether display the workspace name. Non-nil to display in the mode-line.
(setq doom-modeline-workspace-name t)

;; Whether display the perspective name. Non-nil to display in the mode-line.
(setq doom-modeline-persp-name t)

;; If non nil the default perspective name is displayed in the mode-line.
(setq doom-modeline-display-default-persp-name nil)

;; If non nil the perspective name is displayed alongside a folder icon.
(setq doom-modeline-persp-icon t)

;; Whether display the `lsp' state. Non-nil to display in the mode-line.
(setq doom-modeline-lsp t)

;; Whether display the GitHub notifications. It requires `ghub' package.
;; (setq doom-modeline-github nil)

;; The interval of checking GitHub.
;; (setq doom-modeline-github-interval (* 30 60))

;; Whether display the modal state icon.
;; Including `evil', `overwrite', `god', `ryo' and `xah-fly-keys', etc.
;; (setq doom-modeline-modal-icon t)

;; Whether display the mu4e notifications. It requires `mu4e-alert' package.
;; (setq doom-modeline-mu4e nil)

;; Whether display the gnus notifications.
(setq doom-modeline-gnus t)

;; Wheter gnus should automatically be updated and how often (set to 0 or smaller than 0 to disable)
(setq doom-modeline-gnus-timer 2)

;; Wheter groups should be excludede when gnus automatically being updated.
(setq doom-modeline-gnus-excluded-groups '("dummy.group"))

;; Whether display the IRC notifications. It requires `circe' or `erc' package.
(setq doom-modeline-irc t)

;; Function to stylize the irc buffer names.
;; (setq doom-modeline-irc-stylize 'identity)

;; Whether display the environment version.
;; (setq doom-modeline-env-version t)
;; Or for individual languages
(setq doom-modeline-env-enable-python t)
;; (setq doom-modeline-env-enable-ruby t)
;; (setq doom-modeline-env-enable-perl t)
;; (setq doom-modeline-env-enable-go t)
;; (setq doom-modeline-env-enable-elixir t)
;; (setq doom-modeline-env-enable-rust t)

;; Change the executables to use for the language version string
;; (setq doom-modeline-env-python-executable "python") ; or `python-shell-interpreter'
;; (setq doom-modeline-env-ruby-executable "ruby")
;; (setq doom-modeline-env-perl-executable "perl")
;; (setq doom-modeline-env-go-executable "go")
;; (setq doom-modeline-env-elixir-executable "iex")
;; (setq doom-modeline-env-rust-executable "rustc")

;; What to display as the version while a new one is being loaded
;; (setq doom-modeline-env-load-string "...")

;; Hooks that run before/after the modeline version string is updated
;; (setq doom-modeline-before-update-env-hook nil)
;; (setq doom-modeline-after-update-env-hook nil)

;; python send line------
;; Add a function to send a single line to the Python console
(defun python-shell-send-line ()
  (interactive)
  (save-mark-and-excursion
    (move-beginning-of-line nil)
    (set-mark-command nil)
    (move-end-of-line nil)
    (python-shell-send-region
     (region-beginning)
     (region-end)))
  (forward-line)
  (beginning-of-visual-line))

;; Create shortcut
(with-eval-after-load "python" (define-key python-mode-map
                 (kbd "<C-return>")
                 'python-shell-send-line))
