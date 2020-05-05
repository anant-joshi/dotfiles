(package-initialize)

(menu-bar-mode -1)
(tool-bar-mode -1)

(require 'package)

(setq package-enable-at-startup nil)

(setq vc-follow-symlinks t)
(set-frame-font "Fira Code Retina-14" nil t)
(set-default-font "Fira Code Retina-14" nil t)
(set-face-attribute 'default t :font "Fira Code Retina-14")
(setq package-check-signature nil)
(setenv "WORKON_HOME" "~/.env")



(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))           
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))       
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))

;; (use-package solarized-theme
;;   :ensure t
;;   :config
;; ;; make the fringe stand out from the background
;;   (setq solarized-distinct-fringe-background t)

;; ;; Don't change the font for some headings and titles
;;   (setq solarized-use-variable-pitch nil)

;; ;; make the modeline high contrast
;;   (setq solarized-high-contrast-mode-line nil)
;;   (load-theme 'solarized-dark t))

;; (set-default-font "FuraCode Nerd Font-12")
;; (set-frame-font "FuraCode Nerd Font-12" nil t)
(use-package evil
  :ensure t
  :config
  (use-package evil-leader
    :ensure t
    :config
    (evil-leader/set-leader "<SPC>")
    (evil-leader/set-key
      "ci" 'comment-or-uncomment-region
      "cc" 'comment-region
      "cu" 'uncomment-region
      "cd" 'comment-dwim
      "bs" 'switch-to-buffer
      "bj" 'switch-to-next-buffer
      "bl" 'list-buffers
      "bk" 'switch-to-prev-buffer))
    (global-evil-leader-mode)


  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode))

  (use-package evil-indent-textobject
    :ensure t)

  (evil-mode 1))

;; (use-package powerline
;;   :ensure t
;;   :config
;;   (use-package powerline-evil
;;     :ensure t
;;     :config
;;     (powerline-evil-center-color-theme))
;;   ;; (use-package airline-themes
;;   ;;   :ensure t
;;   ;;   :config
;;   ;;   (load-theme 'airline-solarized-gui))
;;   )


(use-package doom-themes
  :ensure t
  :config
  (setq doom-themes-enable-bold t)
  (setq doom-themes-enable-italic t)
  (doom-themes-visual-bell-config)
  (doom-themes-org-config)
  (load-theme 'doom-solarized-dark t)
  (use-package solaire-mode
    :hook
    ((change-major-mode after-revert ediff-prepare-buffer) . turn-on-solaire-mode)
    (minibuffer-setup . solaire-mode-in-minibuffer)
    :config
    (solaire-global-mode +1)
    (solaire-mode-swap-bg)
    ))
;; )
(use-package doom-modeline
  :ensure t
  :config
  (use-package all-the-icons
    :ensure t
    :config)
  (doom-modeline-def-modeline 'evil-line
    '(bar matches modals buffer-info remote-host buffer-position selection-info)
    '(misc-info minor-modes buffer-encoding major-mode vcs checker battery))

  (doom-modeline-def-modeline 'basic-line
    '(bar modals)
    '(major-mode vcs checker))
  (defun setup-custom-doom-modeline()
    (doom-modeline-set-modeline 'evil-line 'default))
  (setq doom-modeline-project-detection 'project
        doom-modeline-icon t
        doom-modeline-buffer-file-name-style 'auto
        doom-modeline-unicode-fallback nil
        doom-modeline-major-mode-color-icon t
        doom-modeline-buffer-state-icon t
        doom-modeline-enable-word-count t
        doom-modeline-modal-icon t)
  (add-hook 'doom-modeline-mode-hook 'setup-custom-doom-modeline) 
  (doom-modeline-mode 1))

(use-package highlight-indent-guides
  :ensure t
  :config
  (setq highlight-indent-guides-method 'character)
  (setq highlight-indent-guides-responsive 'stack)
  (setq highlight-indent-guides-character ?\|)
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode))

(use-package tramp
  :ensure t
  :config
  (setq tramp-default-method "ssh")
  (eval-after-load 'tramp '(setenv "SHELL" "/bin/bash")))

(use-package writeroom-mode
  :ensure t
  :config
  (setq writeroom-mode-line t))

(use-package org
  :ensure t
  :config
  (use-package evil-org
    :ensure t
    :after org
    :config
    (add-hook 'org-mode-hook 'evil-org-mode)
    (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme)))

    (evil-leader/set-key-for-mode 'org-mode
      "t" 'org-todo)))

(use-package projectile
  :ensure t
  :config
  (setq projectile-project-search-path '("~/Documents/Gatech/"))
  (projectile-global-mode))

(use-package keychain-environment
  :ensure t
  :config
  (keychain-refresh-environment))

(use-package yasnippet
  :ensure t
  :config
  (use-package yasnippet-snippets
    :ensure t))


(use-package elpy
  :ensure t
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable)
  :config
  (ido-mode)
  (evil-leader/set-key-for-mode 'python-mode
      "er" 'xref-find-references
      "gd" 'elpy-goto-definition-other-window
      "ga" 'elpy-goto-assignment-other-window
      "od" 'elpy-occur-definitions
      "ef" 'elpy-folding-toggle-at-point
      "es" 'elpy-multiedit-python-symbol-at-point
      "fc" 'elpy-format-code)
  :hook (python-mode . hs-minor-mode))

(use-package tex
  :defer t
  :ensure auctex
  :config
  (setq-default TeX-engine 'xetex)
  (yas-global-mode)
  (prettify-symbols-mode)

  (setq TeX-engine 'xetex
        TeX-auto-save t
        LaTeX-electric-left-right-brace t
        TeX-electric-math t
        TeX-insert-braces t
        TeX-parse-self t
        TeX-source-correlate-mode t
        TeX-source-correlate-start-server t
        reftex-plug-into-AUCTeX t
        company-mode t
        TeX-view-program-selection '((output-pdf "Okular")
                                     (output-html "xdg-open")))

  (use-package company-math
    :ensure t)

  (use-package company-auctex
    :ensure t
    :config
    (company-auctex-init))

  (defun my-latex-mode-setup ()
    (setq-local company-backends
              (append '((company-math-symbols-latex company-latex-commands company-auctex-macros company-math-symbols-unicode company-auctex-environments))
                      company-backends)))

  (add-hook 'LaTeX-mode-hook 'my-latex-mode-setup)
  (add-hook 'LaTeX-mode-hook 'prettify-symbols-mode)
  (add-hook 'LaTeX-mode-hook 'turn-on-reftex)

  (evil-leader/set-key-for-mode 'latex-mode
    "lc" 'TeX-command-master
    "lv" 'TeX-view
    "lp" 'preview-buffer
    "lr" 'preview-clearout-buffer
    "la" 'TeX-command-run-all
    "lm" 'TeX-master-file-ask))

(use-package helm
  :ensure t
  :preface (require 'helm-config)
  :config
  (helm-mode 1))

(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode)
  (add-hook 'LaTeX-mode-hook 'rainbow-delimiters-mode))


(use-package fill-column-indicator
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'fci-mode)
  (add-hook 'LaTeX-mode-hook 'fci-mode))

(defun fira-code-mode--make-alist (list)
  "Generate prettify-symbols alist from LIST."
  (let ((idx -1))
    (mapcar
     (lambda (s)
    (setq idx (1+ idx))
        (let* ((code (+ #Xe100 idx))
        (width (string-width s))
            (prefix ())
            (suffix '(?\s (Br . Br)))
            (n 1))
    (while (< n width)
        (setq prefix (append prefix '(?\s (Br . Bl))))
        (setq n (1+ n)))
    (cons s (append prefix suffix (list (decode-char 'ucs code))))))
        list)))

(defconst fira-code-mode--ligatures
  '("www" "**" "***" "**/" "*>" "*/" "\\\\" "\\\\\\"
    "{-" "[]" "::" ":::" ":=" "!!" "!=" "!==" "-}"
    "--" "---" "-->" "->" "->>" "-<" "-<<" "-~"
    "#{" "#[" "##" "###" "####" "#(" "#?" "#_" "#_("
    ".-" ".=" ".." "..<" "..." "?=" "??" ";;" "/*"
    "/**" "/=" "/==" "/>" "//" "///" "&&" "||" "||="
    "|=" "|>" "^=" "$>" "++" "+++" "+>" "=:=" "=="
    "===" "==>" "=>" "=>>" "<=" "=<<" "=/=" ">-" ">="
    ">=>" ">>" ">>-" ">>=" ">>>" "<*" "<*>" "<|" "<|>"
    "<$" "<$>" "<!--" "<-" "<--" "<->" "<+" "<+>" "<="
    "<==" "<=>" "<=<" "<>" "<<" "<<-" "<<=" "<<<" "<~"
    "<~~" "</" "</>" "~@" "~-" "~=" "~>" "~~" "~~>" "%%"
    "x" ":" "+" "+" "*"))

(defvar fira-code-mode--old-prettify-alist)

(defun fira-code-mode--enable ()
  "Enable Fira Code ligatures in current buffer."
  (setq-local fira-code-mode--old-prettify-alist prettify-symbols-alist)
  (setq-local prettify-symbols-alist (append (fira-code-mode--make-alist fira-code-mode--ligatures) fira-code-mode--old-prettify-alist))
  (prettify-symbols-mode t))

(defun fira-code-mode--disable ()
  "Disable Fira Code ligatures in current buffer."
  (setq-local prettify-symbols-alist fira-code-mode--old-prettify-alist)
  (prettify-symbols-mode -1))

(define-minor-mode fira-code-mode
  "Fira Code ligatures minor mode"
  :lighter " Fira Code"
  (setq-local prettify-symbols-unprettify-at-point 'right-edge)
  (if fira-code-mode
      (fira-code-mode--enable)
    (fira-code-mode--disable)))

(defun fira-code-mode--setup ()
  "Setup Fira Code Symbols"
  (set-fontset-font t '(#Xe100 . #Xe16f) "Fira Code Symbol"))

(provide 'fira-code-mode)

(use-package display-line-numbers
  :ensure t)
(global-display-line-numbers-mode)
(setq display-line-numbers 'visual)
(setq display-line-numbers-type 'visual)
;; (add-to-list 'load-path "~/.emacs.d/packages/highlight-indents/")
;; (require 'highlight-indentation)

;; (set-default-font "Fira Code Retina-12")


(setq-default indent-tabs-mode nil)


(require 'ox-latex)
(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-listings 'minted)

(setq org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#657b83"])
 '(compilation-message-face (quote default))
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-safe-themes
   (quote
    ("2b8dff32b9018d88e24044eb60d8f3829bd6bbeab754e70799b78593af1c3aba" "b181ea0cc32303da7f9227361bb051bbb6c3105bb4f386ca22a06db319b08882" "00445e6f15d31e9afaa23ed0d765850e9cd5e929be5e8e63b114a3346236c44c" "285d1bf306091644fb49993341e0ad8bafe57130d9981b680c1dbd974475c5c7" "7f1d414afda803f3244c6fb4c2c64bea44dac040ed3731ec9d75275b9e831fe5" "830877f4aab227556548dc0a28bf395d0abe0e3a0ab95455731c9ea5ab5fe4e1" "0fffa9669425ff140ff2ae8568c7719705ef33b7a927a0ba7c5e2ffcfac09b75" "51ec7bfa54adf5fff5d466248ea6431097f5a18224788d0bd7eb1257a4f7b773" "13a8eaddb003fd0d561096e11e1a91b029d3c9d64554f8e897b2513dbf14b277" "2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3" default)))
 '(fci-rule-color "#073642")
 '(helm-completion-style (quote emacs))
 '(helm-mode t)
 '(highlight-changes-colors (quote ("#d33682" "#6c71c4")))
 '(highlight-symbol-colors
   (quote
    ("#3b2b40b432a1" "#07ab45f64ce9" "#475733ea3554" "#1d623c04567f" "#2d5343d8332c" "#436f35f73166" "#0613413e597e")))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   (quote
    (("#073642" . 0)
     ("#5b7300" . 20)
     ("#007d76" . 30)
     ("#0061a8" . 50)
     ("#866300" . 60)
     ("#992700" . 70)
     ("#a00559" . 85)
     ("#073642" . 100))))
 '(hl-bg-colors
   (quote
    ("#866300" "#992700" "#a7020a" "#a00559" "#243e9b" "#0061a8" "#007d76" "#5b7300")))
 '(hl-fg-colors
   (quote
    ("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36")))
 '(hl-paren-colors (quote ("#2aa198" "#b58900" "#268bd2" "#6c71c4" "#859900")))
 '(lsp-ui-doc-border "#93a1a1")
 '(nrepl-message-colors
   (quote
    ("#dc322f" "#cb4b16" "#b58900" "#5b7300" "#b3c34d" "#0061a8" "#2aa198" "#d33682" "#6c71c4")))
 '(package-selected-packages
   (quote
    (solaire-mode doom-modeline helm evil-magit magit airline-themes doom-themes highlight-indent-guides yasnippet-snippets writeroom-mode use-package solarized-theme rainbow-delimiters projectile powerline-evil keychain-environment fill-column-indicator evil-surround evil-org evil-leader evil-indent-textobject elpy company-math company-auctex)))
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(safe-local-variable-values (quote ((reftex-default-bibliography "./sol2_refs.bib"))))
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#ca7966832090")
     (60 . "#c05578c91534")
     (80 . "#b58900")
     (100 . "#a6088eed0000")
     (120 . "#9e3a91a60000")
     (140 . "#9628943b0000")
     (160 . "#8dc596ad0000")
     (180 . "#859900")
     (200 . "#76ef9b6045e8")
     (220 . "#6cd69ca95b9d")
     (240 . "#5f5f9e06701f")
     (260 . "#4c1a9f778424")
     (280 . "#2aa198")
     (300 . "#3002984eaf4d")
     (320 . "#2f6f93e8bae0")
     (340 . "#2c598f79c66f")
     (360 . "#268bd2"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#002b36" "#073642" "#a7020a" "#dc322f" "#5b7300" "#859900" "#866300" "#b58900" "#0061a8" "#268bd2" "#a00559" "#d33682" "#007d76" "#2aa198" "#839496" "#657b83")))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
