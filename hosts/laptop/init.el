(defun jrrom/org-babel-tangle-config ()
  (when (or (string-equal (buffer-file-name) (expand-file-name "~/dotfiles/Emacs.org"))
			(string-equal (buffer-file-name) (expand-file-name "~/dotfiles/Programs.org"))
            (string-equal (buffer-file-name) (expand-file-name "~/dotfiles/Sway.org"))
            (string-equal (buffer-file-name) (expand-file-name "~/dotfiles/EWW.org")))
    (org-element-cache-reset)
    (let ((org-confirm-babel-evaluate nil))
      (org-babel-tangle))))

(add-hook 'org-mode-hook (lambda () (add-hook 'after-save-hook #'jrrom/org-babel-tangle-config)))

(setq gc-cons-threshold #x40000000)

(setq read-process-output-max (* 1024 1024 4))

(setenv "LSP_USE_PLISTS" "true")         ;; Use PLISTS instead of JSON
(setq pgtk-wait-for-event-timeout nil)   ;; Don't wait for events to complete?

(require 'package)
(add-to-list
 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

(use-package emacs
  :custom
  ;; Files
  (auto-save-default nil)                   ;; Disable auto save and lockfile creation
  (create-lockfiles nil)
  (make-backup-files nil)                   ;; Disable creation of backup files
  (global-auto-revert-non-file-buffers t)   ;; In conjunction with (global-auto-revert-mode 1) allows to keep up-to-date
  (history-length 200)                      ;; Set the length of the command history.
  (recentf-max-saved-items 100)             ;; number of files to remember with recentf

  ;; Startup
  (inhibit-startup-message t)               ;; Disable the startup message when Emacs launches
  (initial-scratch-message "")              ;; Clear the initial message in the *scratch* buffer

  ;; Misc
  (use-short-answers t)                     ;; Use short answers in prompts for quicker responses (y instead of yes)
  (warning-minimum-level :emergency)        ;; Only emergencies here
  (debug-on-error t)

  ;; Window and movement
  (pixel-scroll-precision-use-momentum nil) ;; Disable momentum scrolling for pixel precision.
  (split-width-threshold 300)               ;; Prevent automatic window splitting if the window width exceeds 300 pixels

  ;; Editing
  (ispell-dictionary nil)                   ;; Set the default dictionary for spell checking
  (text-mode-ispell-word-completion nil)
  (display-line-numbers-type 'relative)     ;; Relative line numbers
  (ring-bell-function 'ignore)              ;; Disable the audible bell and visible bell
  (tab-always-indent 'complete)             ;; Make the TAB key complete text instead of just indenting.
  (tab-width 4)                             ;; Set the tab width to 4 spaces.

  ;; Vertico
  (enable-recursive-minibuffers t)
  ;; Hide commands in M-x which do not work in the current mode.
  (read-extended-command-predicate #'command-completion-default-include-p)
  ;; Do not allow the cursor in the minibuffer prompt
  (minibuffer-prompt-properties
   '(read-only t cursor-intangible t face minibuffer-prompt))
)

(use-package emacs
  :init
  ;; Files
  (auto-revert-mode 1)                      ;; Keeps your Emacs buffers in sync with external changes
  (recentf-mode 1)                          ;; Keep track of recent files!

  ;; Window and Movement
  (pixel-scroll-precision-mode t)           ;; Enable precise pixel scrolling.

  ;; Appearance
  (menu-bar-mode -1)                        ;; Remove menubar
  (tool-bar-mode -1)                        ;; Remove toolbar
  (scroll-bar-mode -1)                      ;; Remove scrollbar
  (global-visual-line-mode 0)               ;; Visual line mode wrapping

  ;; Editing
  (indent-tabs-mode nil)
  (electric-pair-mode 1)

  ;; Vertico
  (context-menu-mode t) ;; Enable context menu for `vertico-multiform-mode'
  :hook (prog-mode . display-line-numbers-mode)
  :config
  (setq-default indent-tabs-mode nil)       ;; Disable the use of tabs for indentation (use spaces instead).
  (prefer-coding-system 'utf-8)             ;; Only UTF8 here
  (setq-default cursor-type 'box))

(add-hook 'emacs-startup-hook
          (lambda ()
            (with-current-buffer "*scratch*"
              (display-line-numbers-mode -1))))

(when (member "Maple Mono" (font-family-list))
  (set-face-attribute 'default nil :font "Maple Mono-15")
  (set-face-attribute 'fixed-pitch nil :family "Maple Mono"))

(when (member "Noto Sans" (font-family-list))
  (set-face-attribute 'variable-pitch nil :font "Noto Sans-16"))

;; Nerd Icons Setup
(set-fontset-font t nil (font-spec :family "Symbols Nerd Font Mono") nil 'append)

;; Mixed pitch mode
(use-package mixed-pitch
  :ensure t
  :hook
  (org-mode . mixed-pitch-mode)
  :custom
  (mixed-pitch-variable-pitch-cursor 'box))

(use-package nerd-icons
  :ensure t
  :custom
  (nerd-icons-font-family "Symbols Nerd Font Mono"))

(use-package ligature
  :ensure t
  :config
  (ligature-set-ligatures
   '(prog-mode org-mode markdown-mode)
   '("::"    "?."    "<#--"      ":::"       "..<"    "<!---->"   "?:"       "#_"
     ".="    "<->"   ":?"        "<~"        "<-->"   ":?>"       "~>"       "<||"
     "->"    "<:"    "~~"        "<-"        ":>"     "<~>"       "-->"      "</>"
     ":<"    "<~~"   "<--"       "<:<"       "~~>"    ">->"       ">:>"      "#="
     "-~"    "<-<"   "__"        "~-"        "|->"    "#{"        "~@"       "+>"
     "<-|"   "#["    "~~~~~~~"   "-------"   "#("     ">--"       "#?"       "#__"
     "<>"    "--<"   "#!"        "</"        "<|||"   "#:"        "/>"       "|||>"
     "<+"    "||>"   "<|"        "#_("       "<+>"    "|>"        "]#"       ">=>"
     "<*>"   "<*>"   "<<<"       ">="        ">>"     "<="        ">>>"      "<=<"
     "=="    "{|"    "==="       "|}"        "!="     "{--"       "!=="      "{{!--"
     "=/="   "--}}"  "=!="       "[|"        "|="     "|]"        "<=>"      "!!"
     "<==>"  "||"    "<=="       "??"        "==>"    "Cl"        "???"      "=>"
     "al"    "&&"    "<=|"       "cl"        "&&&"    "|=>"       "el"       "//"
     "=<="   "il"    "///"       "=>="       "tl"     "/*"        "======="  "ul"
     "/**"   ">=<"   "xl"        "*/"        ":="     "ff"        "++"       "=:"
     "tt"    "+++"   ":=:"       "all"       ";;"     "=:="       "ell"      ";;;"
     "\\\\"  "\\'"   "\\."       "ill"       ".."     "--"        "ull"      "..."
     "---"   "ll"    ".?"        "<!--"
     ;; Not using : "}}" "{{", or any text ligatures - "TODO", etc
     ))
  (global-ligature-mode t))

(use-package gruvbox-theme
  :ensure t
  :config (load-theme 'gruvbox-dark-medium t nil))

(use-package visual-fill-column
  :ensure t
  :custom
  (visual-fill-column-width 80)       ;; max width
  (visual-fill-column-center-text t)) ;; center text

(use-package text-mode
  :custom
  (visual-line-fringe-indicators '(nil right-triangle))
  :hook
  (text-mode . visual-line-mode))

(use-package prog-mode
  :custom
  (visual-line-fringe-indicators '(nil right-triangle)))

(use-package indent-bars
  :ensure t
  :config
  (setq
   indent-bars-pattern "."
   indent-bars-width-frac 0.1
   indent-bars-pad-frac 0.1
   indent-bars-highlight-current-depth '(:face default :blend 0.4))
  :hook ((nix-mode) . indent-bars-mode))

(defun jrrom/org-face-sizes ()
  (dolist (face '((org-level-1 . 1.1)
                  (org-level-2 . 1.05)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.05)
                  (org-level-5 . 1.05)
                  (org-level-6 . 1.05)
                  (org-level-7 . 1.05)
                  (org-level-8 . 1.05)))
    (set-face-attribute (car face) nil :inherit 'variable-pitch :weight 'bold :height (cdr face)))
  (set-face-attribute 'org-document-title nil :inherit 'variable-pitch :weight 'bold :height 1.5))

(use-package org
  :defer t
  :hook (org-mode . (lambda ()
                      (visual-line-mode 1)
                      (modify-syntax-entry ?< "." org-mode-syntax-table) ;; Please don't match < and )
                      (modify-syntax-entry ?> "." org-mode-syntax-table)
                      (setq-local electric-pair-inhibit-predicate
                                  (lambda (c) (when (char-equal c ?<) t)))
                      (when (org-before-first-heading-p)
                        (org-content 2))))
  :custom
  (org-src-tab-acts-natively t)
  (org-src-fontify-natively  t)
  (org-src-preserve-indentation t)
  (org-startup-indented t)               ; Needed for org-modern-indent
  (org-edit-src-content-indentation 0)
  (org-modern-checkbox nil)              ; No fancy unicode checkboxes please
  :config
  (jrrom/org-face-sizes))

;; (use-package org-modern
;;  :ensure t
;;  :after org
;;  :init (with-eval-after-load 'org (global-org-modern-mode)))

;; (use-package org-modern-indent
;;  :vc (:url "https://github.com/jdtsmith/org-modern-indent.git" :rev :newest)
;;  :ensure t
;;  :config ; add late to hook
;;  (add-hook 'org-mode-hook #'org-modern-indent-mode))

(use-package org-contrib
  :ensure t
  :defer t
  :after org)

(use-package org-babel
  :no-require
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((python . t)
	 (emacs-lisp . t)
	 (shell . t))))

(use-package repeat
  :ensure nil
  :config
  (repeat-mode))

(use-package which-key
  :config
  (which-key-setup-side-window-right-bottom)
  (which-key-mode))

(use-package eldoc
  :init
  (global-eldoc-mode))

(use-package eldoc-box
  :ensure t
  :bind
  ("C-h ." . eldoc-box-help-at-point))

(use-package avy
  :ensure t
  :bind
  ("M-j" . avy-goto-char-timer))

;; For conf-mode (ini/conf files)
(use-package conf-mode
  :ensure nil   ;; it's built-in
  :hook (conf-mode . (lambda () (setq indent-tabs-mode t))))

(use-package ebuild-mode
  :ensure nil
  :hook (conf-mode . (lambda () (setq indent-tabs-mode t))))

;; For Makefiles (needs tabs)
(use-package make-mode
  :ensure nil
  :hook (makefile-mode . (lambda () (setq indent-tabs-mode t))))

(use-package vertico
  :ensure t
  :custom
  ;; (vertico-scroll-margin 0) ;; Different scroll margin
  ;; (vertico-count 20) ;; Show more candidates
  ;; (vertico-resize t) ;; Grow and shrink the Vertico minibuffer
  (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  :init
  (vertico-mode))

(use-package embark
  :ensure t
  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h b" . embark-bindings)) ;; alternative for `describe-bindings'

  :init
  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  :config
  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :ensure t ; only need to install it, embark loads it after consult if found
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

;; Enable rich annotations using the Marginalia package
(use-package marginalia
  :ensure t
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  ;; The :init section is always executed.
  :init

  ;; Marginalia must be activated in the :init section of use-package such that
  ;; the mode gets enabled right away. Note that this forces loading the
  ;; package.
  (marginalia-mode))

;; Example configuration for Consult
(use-package consult
  :ensure t
  ;; Replace bindings. Lazily loaded by `use-package'.
  :bind (;; C-c bindings in `mode-specific-map'
         ("C-c M-x" . consult-mode-command)
         ("C-c h" . consult-history)
         ("C-c i" . consult-info)
         ([remap Info-search] . consult-info)
         ;; C-x bindings in `ctl-x-map'
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x t b" . consult-buffer-other-tab)    ;; orig. switch-to-buffer-other-tab
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ;; M-g bindings in `goto-map'
         
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ;; M-s bindings in `search-map'
         ("M-s g" . consult-ripgrep)
         ("C-s" . consult-line)                    ;; orig. isearch
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)
         :map minibuffer-local-map
         ("M-s" . consult-history)
         ("M-r" . consult-history))            ;; needed by consult-line to detect isearch

  ;; The :init configuration is always executed (Not lazy)
  :init
  ;; Tweak the register preview for `consult-register-load',
  ;; `consult-register-store' and the built-in commands.  This improves the
  ;; register formatting, adds thin separator lines, register sorting and hides
  ;; the window mode line.
  (advice-add #'register-preview :override #'consult-register-window)
  (setq register-preview-delay 0.5)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key "M-.")
  ;; (setq consult-preview-key '("S-<down>" "S-<up>"))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep consult-man
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; "C-+"

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (keymap-set consult-narrow-map (concat consult-narrow-key " ?") #'consult-narrow-help)
)

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides
   '((file (styles basic partial-completion))))
  (completion-pcm-leading-wildcard t)) ;; Emacs 31: partial-completion behaves like substring

(use-package corfu
  :ensure t
  :custom
  (corfu-cycle t)
  :init
  (global-corfu-mode)
  )

(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-install t)
  :config
  (treesit-auto-add-to-auto-mode-alist '(bash c nix))
  (global-treesit-auto-mode))

(use-package eglot
  :ensure nil
  :custom
  (eglot-ignored-server-capabilities '(:documentOnTypeFormattingProvider))
  :bind (:map eglot-mode-map
              ;; L in namespace stands for LSP
	          ("C-c l a" . eglot-code-actions)
	          ("C-c l r" . eglot-rename)
	          ("C-c l h" . eldoc)
	          ("C-c l f" . eglot-format)
	          ("C-c l F" . eglot-format-buffer)
	          ("C-c l d" . xref-find-definitions-at-mouse)
	          ;; sometimes 
	          ("C-c l R" . eglot-reconnect)))

(use-package nix-mode
  :ensure t
  :mode "\\.nix\\'")

(use-package envrc
  :ensure t
  :hook (after-init . envrc-global-mode))

(add-to-list 'load-path "/nix/var/nix/profiles/default/bin")
(add-to-list 'load-path (expand-file-name "~/.nix-profile/bin"))

(use-package c-ts-mode
  :hook
  (c-ts-mode . (lambda ()
                 (c-ts-mode-set-style 'k&r)
                 (setq c-ts-mode-indent-offset 4))))

(use-package ess
  :ensure t
  :custom
  (ess-style 'RStudio)
  (ess-indent-offset 2))

(use-package polymode
  :hook
  (polymode-init-host  . visual-fill-column-mode)
  (polymode-init-inner . visual-fill-column-mode)
  :hook
  (polymode-init-host  . (lambda () (setq-local font-lock-maximum-decoration 1)))
  (polymode-init-inner . (lambda () (setq-local font-lock-maximum-decoration 1)))
  :ensure t)

(use-package poly-R
  :ensure t)

(use-package poly-markdown
  :ensure t)

;; For editing markdown code blocks!
(use-package edit-indirect
  :ensure t)

(use-package markdown-mode
  :ensure t
  :hook
  (markdown-mode . visual-fill-column-mode)
  :config
  (setq markdown-fontify-code-blocks-natively t
        markdown-code-lang-modes
        '(("r" . ess-r-mode)
          (" {r" . ess-r-mode)
          ("{r"  . ess-r-mode) 
          ("python" . python-mode)
          ("bash" . shell-script-mode))))

(use-package fish-mode
  :ensure t)

(use-package yuck-mode
  :ensure t
  :hook
  (yuck-mode . (lambda () (setq-local lisp-indent-function #'common-lisp-indent-function))))

(use-package clojure-mode
  :ensure t)

(use-package ebuild-mode
  :ensure nil) ;; ensure nil

(use-package dired
  :custom
  (dired-dwim-target t)
  (dired-recursive-copies 'always)  ;; Never ask for confirmation regarding directories
  (dired-recursive-deletes 'top)    ;; see above
  (delete-by-moving-to-trash t)
  (dired-mouse-drag-files t)                   ; Mouse support for dragging and dropping
  (mouse-drag-and-drop-region-cross-program t) ; added in Emacs 29
  ;;  (dired-kill-when-opening-new-dired-buffer t)
  (dired-listing-switches "-l --almost-all --human-readable --group-directories-first --no-group")
  :config
  ;; this command is useful when you want to close the window of `dirvish-side'
  ;; automatically when opening a file
  (put 'dired-find-alternate-file 'disabled nil))

(use-package dired-open-with
  :ensure t)

(use-package dirvish
  :ensure t
  :after dired
  :init (dirvish-override-dired-mode)
  :custom
  (dirvish-quick-access-entries ; It's a custom option, `setq' won't work
   '(("h" "~/"                          "Home")
     ("d" "~/Downloads/"                "Downloads")
	 ("p" "~/Projects/"                 "Projects")))
  :config
  (dirvish-peek-mode 0)              ; Preview files in minibuffer
  (dirvish-side-follow-mode)       ; similar to `treemacs-follow-mode'
  ;; Order matters in attributes
  (setq dirvish-attributes '(vc-state subtree-state nerd-icons collapse git-msg file-time file-size file-modes)
        dirvish-side-attributes '(vc-state nerd-icons collapse))
  ;; open large directory (over 20000 files) asynchronously with `fd' command
  (setq dirvish-large-directory-threshold 20000)
  (setq dirvish-default-layout '(0 0 0.4))
  :bind ; Bind `dirvish-fd|dirvish-side|dirvish-dwim' as you see fit
  (("C-c f" . dirvish)
   ("C-c t" . dirvish-side)
   :map dirvish-mode-map               ; Dirvish inherits `dired-mode-map'
   (";"   . dired-up-directory)        ; So you can adjust `dired' bindings here
   ("?"   . dirvish-dispatch)          ; [?] a helpful cheatsheet
   ("a"   . dirvish-setup-menu)        ; [a]ttributes settings:`t' toggles mtime, `f' toggles fullframe, etc.
   ("f"   . dirvish-file-info-menu)    ; [f]ile info
   ("o"   . dirvish-quick-access)      ; [o]pen `dirvish-quick-access-entries'
   ("s"   . dirvish-quicksort)         ; [s]ort flie list
   ("r"   . dirvish-history-jump)      ; [r]ecent visited
   ("l"   . dirvish-ls-switches-menu)  ; [l]s command flags
   ("*"   . dirvish-mark-menu)
   ("y"   . dirvish-yank-menu)
   ("N"   . dirvish-narrow)
   ("^"   . dirvish-history-last)
   ("TAB" . dirvish-subtree-toggle)
   ("M-e" . dirvish-emerge-menu)))

(use-package vterm
  :ensure t
  :config
  (setq vterm-shell "fish")
  (global-set-key (kbd "C-x 5 t") 'vterm-other-frame))

(defun vterm-other-frame ()
  "Create a new frame with vterm inside of it"
  (interactive)
  (select-frame-set-input-focus (make-frame))
  (vterm))

(use-package emms
  :ensure t
  :config
  (require 'emms-player-mpv)
  (require 'emms-player-mplayer)
  (emms-all)
  (setq emms-player-list '(emms-player-mplayer emms-player-mpv)
        emms-info-functions '(emms-info-exiftool emms-info-native)
        emms-cache-file "~/.config/emacs/emms/cache")
  (emms-cache-enable)

  (add-hook 'emms-tag-editor-mode-hook
            (lambda ()
              (setq-local face-remapping-alist '((default fixed-pitch))))))

(defun emms-jrrom-player ()
  "jrrom's music player setup for EMMS"
  (interactive)
  (select-frame-set-input-focus
   (make-frame
    '((emms-frame . t)))) ;; Setting property
  (emms)
  (emms-mark-mode))

(defun emms-jrrom-close ()
  "Close the current EMMS frame and related buffers"
  (interactive)
  (dolist (frame (frame-list))
    (when (frame-parameter frame 'emms-frame)
      (delete-frame frame))))
