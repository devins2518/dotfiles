(setq gc-cons-threshold 50000000)
(setq large-file-warning-threshold 100000000)
(setq-default truncate-lines t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-to-list 'default-frame-alist '(font . "Iosevka Nerd Font Mono:size=12" ))
(column-number-mode t)
(global-hl-line-mode 1)
(setq default-directory (expand-file-name "~/"))
(setq-default indent-tabs-mode nil)

(use-package general)
(use-package evil
  :after general
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (general-define-key
   :states 'normal
   "C-e" 'help-command
   "C-j" 'evil-window-down
   "C-k" 'evil-window-up
   "C-l" 'evil-window-right
   "C-h" 'evil-window-left
   "++" 'comment-line)
  (general-define-key
   :states 'visual
   "++" 'comment-line)
  (evil-mode 1))
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))
(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode 1))
(use-package evil-numbers
  :after evil
  :config
  (define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
  (define-key evil-normal-state-map (kbd "C-x") 'evil-numbers/dec-at-pt))
(use-package which-key
  :after (evil)
  :config
  (which-key-mode)
  (which-key-setup-side-window-bottom))
(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode 1))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-center-content t)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-footer nil)
  (setq dashboard-set-file-icons t)
  (setq dashboard-items '((recents  . 5)
				    (projects . 5)
                        (agenda . 5))))
(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-tokyo-night t)
  (doom-themes-visual-bell-config))
(use-package all-the-icons
  :if (display-graphic-p)
  :config
  (setq all-the-icons-scale-factor 1.0))
(use-package treemacs
    :after (evil evil-collection all-the-icons doom-themes)
    :config
    (general-define-key
     :states 'normal
     "C-n" 'treemacs)
    (setq doom-themes-treemacs-theme "doom-colors")
    (setq doom-themes-treemacs-enable-variable-pitch nil)
    (doom-themes-treemacs-config))
(use-package smartparens
    :hook (prog-mode . smartparens-mode))
(use-package rainbow-delimiters
    :hook (prog-mode . rainbow-delimiters-mode))
(use-package projectile
  :after which-key
  :init
  (projectile-mode +1)
  :config
  (general-define-key
   :prefix "SPC"
   :states 'normal
   "t" 'projectile-command-map)
  (setq projectile-project-search-path '(("~/Repos/" . 1))))
(use-package highlight-indent-guides
    :hook (prog-mode . highlight-indent-guides-mode)
    :config
    (setq highlight-indent-guides-method 'character))
(use-package flycheck
  :hook (prog-mode . flycheck-mode))
(use-package flycheck-inline
    :after flycheck
    :hook (flycheck-mode . flycheck-inline-mode))
(use-package company
  :hook (prog-mode . company-mode)
  :config (setq company-tooltip-align-annotations t)
          (setq company-minimum-prefix-length 1))
(use-package lsp-mode
  :commands lsp
  :hook ((prog-mode . lsp-mode)
         (lsp-mode . lsp-enable-which-key-integration))
  :init (setq lsp-command-map "SPC l")
  :config
   (general-define-key
      :prefix "SPC l"
      :states '(normal visual emacs)
      :keymaps 'override
        "=" '(:ignore t :which-key "format")
        "=b" '(lsp-format-buffer :which-key "format-buffer")
        "=r" '(lsp-format-region :which-key "format-region")
        "g" '(:ignore t :which-key "goto")
        "gt" '(lsp-goto-type-definition :which-key "goto-type-definition")
        "T" '(:ignore t :which-key "Toggle")
        "r" '(:ignore t :which-key "refactor")
        "r" '(lsp-rename :which-key "rename")
   ))
(use-package lsp-ui
    :after lsp-mode
    :config
    (setq lsp-lens-enable nil)
    (setq lsp-ui-sideline-enable nil)
    (setq lsp-eldoc-enable-hover nil))
(use-package toml-mode)
(use-package rust-mode
  :hook (rust-mode . lsp))
(use-package flycheck-rust
  :config (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))


(use-package key-chord
    :after evil
    :config
    (key-chord-mode 1)
    (setq key-chord-two-keys-delay 0.5)
    (key-chord-define evil-insert-state-map "jk" 'evil-normal-state))

; Properly set exec path
(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

;; Dylib fetching broken for M1
					; (use-package tree-sitter
					;   :init
					;   (setq tsc-dyn-get-from :compilation)
					;   :config
					;   (cl-pushnew (expand-file-name "~/.config/nvim/parser") tree-sitter-load-path)
					;   (global-tree-sitter-mode)
					;   (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))
