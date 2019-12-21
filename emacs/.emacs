(package-initialize)

(menu-bar-mode -1)
(tool-bar-mode -1)

(require 'package)

(setq package-enable-at-startup nil)

(setq vc-follow-symlinks t)

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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (solarized-dark)))
 '(custom-safe-themes
   (quote
    ("2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(display-line-numbers-type (quote relative))
 '(minimap-dedicated-window nil)
 '(minimap-highlight-line nil)
 '(minimap-window-location (quote right))
 '(package-selected-packages
   (quote
    (minimap elpy helm-projectile org-projectile projectile rainbow-delimiters evil-indent-textobject writeroom-mode py-autopep8 ggtags helm-bibtex helm-gitlab helm-gtags helm-pydoc evil-indent-plus yasnippet-snippets use-package solarized-theme powerline-evil org-link-minor-mode org-evil lua-mode java-snippets helm evil-visual-mark-mode evil-surround evil-org evil-nerd-commenter evil-matchit evil-magit evil-leader evil-commentary)))
 '(visible-bell t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#002b36" :foreground "#839496" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 110 :width normal :foundry "1ASC" :family "Noto Sans Mono"))))
 '(minimap-active-region-background ((t (:background "steel blue")))))

(require 'powerline-evil)
(require 'powerline)
(powerline-evil-center-color-theme)



(require 'evil)
(evil-mode t)

(use-package evil
  :ensure t
  :config
  (evil-mode 1)


    :ensure t
    :config
    (global-evil-leader-mode)
    (evil-leader/set-leader "<SPC>")
    (evil-leader/set-key
      "ci" 'comment-or-uncomment-region
      "cc" 'comment-region
      "cu" 'uncomment-region
      "cd" 'comment-dwim
      "bs" 'switch-to-buffer
      "bj" 'switch-to-next-buffer
      "bk" 'switch-to-prev-buffer)

  (use-package evil-surround
    :ensure t
    :config
    (global-evil-surround-mode))

  (use-package evil-indent-textobject
    :ensure t))

(use-package projectile
  :ensure t
  :config
  (setq projectile-project-search-path '("~/Documents/Gatech/"))
  (projectile-mode))

(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode 1)
  (setq display-line-numbers 'relative))
(add-to-list 'load-path "~/.emacs.d/packages/highlight-indents/")
(require 'highlight-indentation)

(set-default-font "Fira Code Retina-11")
(setq package-check-signature nil)

(setq-default indent-tabs-mode nil)

(setq tramp-default-method "ssh")
(require 'ox-latex)
(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-latex-listings 'minted)

(setq org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

