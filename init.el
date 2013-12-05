;; Initial Setup
;;; Set up initial packages via ELPA

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                          ("marmalade" . "http://marmalade-repo.org/packages/")
                          ("melpa" . "http://melpa.milkbox.net/packages/")))
(package-initialize)
(defvar my-packages '(auto-complete js3-mode yasnippet autopair flx-ido scss-mode projectile use-package tabbar tabbar-ruler diminish editorconfig rainbow-mode rainbow-delimiters))

;;;; Install them if they aren't installed already.
(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; Load Paths
(add-to-list 'load-path "~/.emacs.d/site-lisp")
(add-to-list 'load-path "~/.emacs.d")

;; Now load my configs:
(require 'settings)

;; Configure our packages:

;;;; First, make sure use-package is loaded.
(require 'use-package)

;;;;; And diminish to help out our poor modeline
(require 'diminish)

;;;; ECB the Emacs Code Browser
;;;;;
;;;;; Bound to f12. Fun!

(use-package ecb
  :config (progn
            (setq ecb-tip-of-the-day nil)
            (setq ecb-layout-name "left15")
            )
  :bind ("<f12>" . ecb-activate)
  :load-path "site-lisp/ecb"
  )

;;;; JavaScript

;;js mode steals TAB, let's steal it back for yasnippet
(defun js-tab-properly ()
  (interactive)
  (let ((yas/fallback-behavior 'return-nil))
    (unless (yas/expand)
      (indent-for-tab-command)
      (if (looking-back "^\s*")
        (back-to-indentation)))))

(use-package js3-mode
  :mode ("\\.js[on]*$" . js3-mode)
  :diminish (js3-mode . "js3")
  :config (progn
            (define-key js3-mode-map (kbd "TAB") 'js-tab-properly)
            (add-hook 'js3-mode-hook 'autopair-mode)
            )
  )

;;;; Auto Pair (magical parens and braces)
(use-package autopair
  :commands autopair-mode
  :diminish (autopair-mode . " AP")
  )

;;;; flx-ido (flexible ido)
(use-package flx-ido
  :init (progn
          (ido-mode 1)
          (ido-everywhere 1)
          (flx-ido-mode 1)
          ;; disable ido faces to see flx highlights.
          (setq ido-use-faces nil)
          )
  )

;;;; Coffeescript
(use-package coffee-mode
  :load-path "site-lisp/coffee-mode"
  :mode ("\\.coffee" . coffee-mode))

;;;; SCSS mode for css & scss
(use-package scss-mode
  :mode ("\\.\[s\]\*css$" . scss-mode))


;;;; web mode
(use-package web-mode
  :diminish "W "
  :load-path "site-lisp/web-mode"
  :config (progn
            (add-hook 'web-mode-hook 'autopair-mode)
            (setq web-mode-markup-indent-offset 2)
            (setq web-mode-css-indent-offset 2)
            (setq web-mode-code-indent-offset 2)
            )
  :init (progn
          (add-to-list 'auto-mode-alist '("\\.php$" . web-mode))
          (add-to-list 'auto-mode-alist '("\\.ihtml$" . web-mode))
          (add-to-list 'auto-mode-alist '("\\.inc$" . web-mode))
          (add-to-list 'auto-mode-alist '("\\.html$" . web-mode))
          (add-to-list 'auto-mode-alist '("\\.tpl$" . web-mode))
          )
  )

;;;; YASnippets!

(use-package yasnippet
  :init (progn
          (diminish 'yas-minor-mode " ¥")
          (yas-global-mode 1)
          )
  )


;;;; Auto Complete
;;;;; Doesn't play well with use-package, so we go back to require:
(eval-after-load "auto-complete" '(diminish 'auto-complete-mode " ©"))
(require 'auto-complete-config)
(require 'ac-yasnippet)
;; dirty fix for having AC everywhere
(define-globalized-minor-mode real-global-auto-complete-mode
  auto-complete-mode (lambda ()
                       (if (not (minibufferp (current-buffer)))
                         (auto-complete-mode 1))
                       ))
(real-global-auto-complete-mode t)

;;;; Projectile
;;;;; Same with Projectile
(require 'projectile)
(projectile-global-mode)
(diminish 'projectile-mode " ¶")

;;;; Editor Config
;;;;; Same here. BTW- read more here:
;;;;; http://editorconfig.org/
(require 'editorconfig)

;;;; Rainbow Mode & Delimiters (pretty colors!!)
(require 'rainbow-mode) ;; colors hex codes like a #bada55
(require 'rainbow-delimiters)
(global-rainbow-delimiters-mode)


;;;; Buffer cleanup
(use-package cleanup-buffer
  :bind ("C-c C-c" . bj/cleanup-buffer))

;;;; Misc. Functions
(require 'my-functions)

;;;; TabBar (limited to files in project)
(setq tabbar-ruler-global-tabbar t) ; If you want tabbar
(require 'tabbar-ruler)
(tabbar-ruler-group-by-projectile-project)
