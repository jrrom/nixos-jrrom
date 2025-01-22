(require 'use-package)
(setq use-package-always-ensure t)

(use-package emacs
  :init
  ;; Enable PLISTS for speed
  (setenv "LSP_USE_PLISTS" "true")
  ;; Weird Wayland magic
  (setq pgtk-wait-for-event-timeout nil)  
  (scroll-bar-mode -1) ; Disable visible scrollbar
  (tool-bar-mode -1)   ; Disable visible toolbar
  (tooltip-mode -1)    ; Disable tooltips
  (set-fringe-mode 10) ; "Give some breathing room"
  (menu-bar-mode -1)   ; Disable menubar
  (electric-pair-mode) ; Electric pairs!
  
  :config
  ;; Indentation
  (setq-default indent-tabs-mode nil)
  (setq-default tab-width 4)
  (setq-default standard-indent 4)
  ;; Display
  (setq inhibit-startup-message t)
  (setq make-backup-files nil)
  (setq visible-bell t) ; Visible bell
  ;; Disable custom-set-variables appearing in init.el
  (setq custom-file (concat user-emacs-directory "/custom.el"))
  (load-file (concat user-emacs-directory "/custom.el"))
  ;; Scrolling
  (setq scroll-step 1)
  (setq scroll-margin 5)
  (pixel-scroll-precision-mode)
  ;; Save history
  (setq history-length 100)
  (savehist-mode 1)
  ;; Enable recursive minibuffers
  (setq enable-recursive-minibuffers t)
  ;; Modeline on top
  (setq-default header-line-format mode-line-format)
  (setq-default mode-line-format nil)
  ;; Transparency
  ;; (add-to-list 'default-frame-alist '(alpha-background . 90))
  ;; Auto-Completions
  (setq completion-prefix-min-length 1)
  ;; Cursor
  (setq-default cursor-type 'bar)
  ;; Better errors
  ;;(setq debug-on-error t)
  ;; Currently disabled because eglot is whiny

  ;; Corfu settings
  :custom
  (tab-always-indent 'complete)
  (text-mode-ispell-word-completion nil)
  ;; Hide commands in M-x which do not apply to the current mode.  Corfu
  ;; commands are hidden, since they are not used via M-x. This setting is
  ;; useful beyond Corfu.
  (read-extended-command-predicate #'command-completion-default-include-p))

;; =================================
;; Packages and package management
;; =================================

;; Initialise Packages
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)

;; Initialise use-package
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Quelpa
(use-package quelpa
  :config (setq quelpa-update-melpa-p nil))

(quelpa
 '(quelpa-use-package
   :fetcher git
   :url "https://github.com/quelpa/quelpa-use-package.git"))
(require 'quelpa-use-package)

;; which-key
(use-package which-key
  :init (which-key-mode)
  :config (which-key-setup-side-window-right))

;; Gruvbox Theme
(use-package gruvbox-theme
  :init (load-theme 'gruvbox-dark-medium t nil))

;; Ligature Support
(use-package ligature
  :config
  (ligature-set-ligatures 't '("www"))
  (ligature-set-ligatures
   'prog-mode
   '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
     ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
     "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
     "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
     "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
     "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
     "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
     "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
     ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
     "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
     "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
     "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
     "\\\\" "://"))
  (global-ligature-mode t))

;; Flymake Errors
(use-package flymake
  :config
  (add-hook 'after-init-hook #'flymake-mode))

;; Eldoc
(use-package eldoc
  :init
  (global-eldoc-mode))

(use-package avy
  :bind ("M-g w" . avy-goto-word-0)
        ("M-g c" . avy-goto-char))

;; Repeat commands, for example: C-x o o o to keep changing window
(use-package repeat
  :config
  (repeat-mode))

;; =================================
;; Vemco Stack
;; =================================

;; Autocompletions in minibuffer
(use-package vertico
  :init (vertico-mode))

(use-package embark
  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

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

;; Enable rich annotations
(use-package marginalia
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  :init (marginalia-mode))

;; Consult
(use-package consult
  ;; Replace bindings. Lazily loaded due by `use-package'.
  :bind (;; C-c bindings in `mode-specific-map'
         ("C-c M-x" . consult-mode-command)
         ("C-c h" . consult-history)
         ("C-c k" . consult-kmacro)
         ("C-c m" . consult-man)
         ("C-h i" . consult-info)
         ([remap Info-search] . consult-info)
         ;; C-x bindings in `ctl-x-map'
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x t b" . consult-buffer-other-tab)    ;; orig. switch-to-buffer-other-tab
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("C-y" . consult-yank-pop)                ;; orig. yank-pop
         ;; M-g bindings in `goto-map'
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flycheck)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)             ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ;; M-s bindings in `search-map'
         ("M-s d" . consult-find)                  ;; Alternative: consult-fd
         ("M-s G" . consult-git-grep)
         ("M-s g" . consult-ripgrep)
         ("C-s" . consult-line)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("C-s" . consult-line)                  ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-n" . consult-history)                 ;; orig. next-matching-history-element
         ("M-p" . consult-history))                ;; orig. previous-matching-history-element

  ;; Enable automatic preview at point in the *Completions* buffer.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key "M-."
   :preview-key '(:debounce 0.4 any)))

;; Smart completion to search with space separated patterns
(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; Built-in project manager
(require 'project)

;; =================================
;; Programming Language Support
;; =================================

;; Treesitter
(require 'treesit)
(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

;; Company
(use-package corfu
  :custom
  (corfu-cycle t)
  ;; (keymap-unset corfu-map (kbd "C-n"))
  ;; (keymap-unset corfu-map (kbd "C-p"))
  (keymap-unset corfu-map "RET")
  ;; (define-key corfu-map (kbd "M-n") #'corfu-scroll-down)
  ;; (define-key corfu-map (kbd "M-p") #'corfu-scroll-up)
  :bind
  (:map corfu-map
        ("M-n" . corfu-next)
        ("M-p" . corfu-previous)
        ("M-n" . corfu-scroll-down)
        ("M-p" . corfu-scroll-up))
  :init
  (global-corfu-mode)
  :config
  (keymap-unset corfu-map "RET")
  (setq corfu-auto t
        auto-delay 0
        corfu-auto-prefix 3))

;; Emacs Corfu settings
(use-package emacs
  :custom
  (tab-always-indent 'complete)
  (text-mode-ispell-word-completion nil)
  ;; Hide commands in M-x which do not apply to the current mode.  Corfu
  ;; commands are hidden, since they are not used via M-x. This setting is
  ;; useful beyond Corfu.
  (read-extended-command-predicate #'command-completion-default-include-p))

;; LSP
(use-package eglot
  :hook (prog-mode . eglot-ensure)
  :init
  (setq eglot-stay-out-of '(flymake)))

;; Direnv
(use-package envrc
  :hook (after-init . envrc-global-mode))

;; Editorconfig
(use-package editorconfig
  :hook (prog-mode . editorconfig-mode))

;; Magit
(use-package magit
  :bind
  (:map magit-map
   ("C-x g" . magit-status)
   ("C-c g" . magit-dispatch)
   ("C-c f" . magit-file-dispatch)))

;; DAPE debugger
(use-package dape
  :config
  (dape-breakpoint-global-mode)
  (setq dape-buffer-window-arrangement 'right)
  (setq dape-inlay-hints t)
  (add-hook 'dape-compile-hook 'kill-buffer))

;; =================================
;; Languages
;; =================================

;; Web Mode
(use-package web-mode
  :ensure t
  :mode "\\.html?\\'"
  :mode "\\.css\\'"
  :mode "\\.phtml\\'"
  :mode "\\.tpl\\.php\\'"
  :mode "\\.[agj]sp\\'"
  :mode "\\.as[cp]x\\'"
  :mode "\\.erb\\'"
  :mode "\\.mustache\\'"
  :mode "\\.djhtml\\'"
  :config
  (setq web-mode-markup-indent-offser 2
        web-mode-code-indent-offset 2))

;; Nix

(use-package nix-mode
  :mode "\\.nix\\'")

;; =================================
;; Keybindings
;; =================================

;; Move cursor to end of current line
;; Insert new line below current line
;; it will also indent newline
(global-set-key
 (kbd "<C-return>")
 (lambda ()
   (interactive)
   (end-of-line)
   (newline-and-indent)))

;; Move cursor to previous line
;; Go to end of the line
;; Insert new line below current line (So it actually insert new line above with indentation)
;; it will also indent newline
(global-set-key
 (kbd "<C-S-return>")
 (lambda ()
   (interactive)
   (previous-line)
   (end-of-line)
   (newline-and-indent)))

;; Duplicate line
(global-set-key
 (kbd "C-S-y")
 (lambda ()
   (interactive)
   (let* ((pos-end (line-beginning-position 2))
         (line    (buffer-substring (line-beginning-position) pos-end)))
    (goto-char pos-end)
    (unless (bolp) (newline))
    (save-excursion ;; leave point before the duplicate line
      (insert line)))
   (end-of-line)))
