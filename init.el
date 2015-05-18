;; Start the server, if it's not running
;(load "server")
;(unless (server-running-p) (server-start))

;; Initial Setup
;;; Set up initial packages via ELPA

(require 'package)
(setq package-archives '(("melpa" . "http://melpa.milkbox.net/packages/")
                         ("gnu" . "http://elpa.gnu.org/packages/")
                          ("marmalade" . "http://marmalade-repo.org/packages/")))


(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.

Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     ;; (package-installed-p 'evil)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))

;; make sure to have downloaded archive description.
;; Or use package-archive-contents as suggested by Nicolas Dudebout
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

;; activate installed packages
(package-initialize)


(ensure-package-installed 'auto-complete 'js3-mode 'yasnippet 'autopair 'flx-ido 'scss-mode 'use-package 'diminish 'editorconfig 'rainbow-mode 'rainbow-delimiters 'literate-coffee-mode 'wakatime-mode 'dash 'pkg-info)




;; Load Paths
(add-to-list 'load-path "~/.emacs.d/site-lisp")

;; Now load my configs:
(require 'settings)

;; Color themes:
;;(add-to-list 'custom-theme-load-path "~/.emacs.d/site-lisp/color-themes")
;;(load "~/.emacs.d/site-lisp/color-themes/gtk-ide-theme.el")


;; Configure our packages:

;;;; First, make sure use-package is loaded.
(require 'use-package)

;;;;; And diminish to help out our poor modeline
(require 'diminish)

;;;; ECB the Emacs Code Browser
;;;;;
;;;;; Bound to f12. Fun!

;(use-package ecb
;  :config (progn
;            (setq ecb-tip-of-the-day nil)
;            (setq ecb-layout-name "left15")
;            )
;  :bind ("<f12>" . ecb-activate)
;  :load-path "site-lisp/ecb"
;  )

;;;; JavaScript

;;js mode steals TAB, let's steal it back for yasnippet
(defun js-tab-properly ()
  (interactive)
  (let ((yas/fallback-behavior 'return-nil))
    (unless (yas/expand)
      (indent-for-tab-command)
      (if (looking-back "^\s*")
        (back-to-indentation)))))

;;; tern is for javascript-y goodness
;;; http://ternjs.net/doc/manual.html#emacs

;; (add-to-list 'load-path "/home/bryan/bin/tern/emacs")
;; (autoload 'tern-mode "tern.el" nil t)
;; (eval-after-load 'tern
;;    '(progn
;;       (require 'tern-auto-complete)
;;       (tern-ac-setup)))
 
(use-package js3-mode
  :mode ("\\.js[on]*$" . js3-mode)
  :diminish (js3-mode . "js3")
  :config (progn
            (define-key js3-mode-map (kbd "TAB") 'js-tab-properly)
            (add-hook 'js3-mode-hook 'autopair-mode)
;            (add-hook 'js3-mode-hook (lambda () (tern-mode t)))
            (add-hook 'js3-mode-hook (lambda () ( setq mode-name "js3" )))
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
  :mode ("\\.coffee" . coffee-mode)
  :config (progn
    (make-local-variable 'tab-width)
    (set 'tab-width 2)
    (setq coffee-assign-regexp "\(\(\w\|\.\|_\|$\)+?\s*\)=")
  )
)

;;;; SCSS mode for css & scss
(use-package scss-mode
  :mode ("\\.\[s\]\*css$" . scss-mode))


;;;; web mode
(use-package web-mode
;  :diminish "W "
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
  :config (progn
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
(add-to-list 'load-path "~/.emacs.d/site-lisp/projectile")
(require 'projectile)
(projectile-global-mode)
(diminish 'projectile-mode " ¶")

(add-to-list 'load-path "~/.emacs.d/site-lisp/perspective")
(require 'perspective)
(persp-mode)
(require 'persp-projectile)

;;;; Wakatime tracks time spent per projectile project
(require 'wakatime-mode)
(global-wakatime-mode)
(diminish 'wakatime-mode " $")

;;;; Editor Config
;;;;; Same here. BTW- read more here:
;;;;; http://editorconfig.org/
(require 'editorconfig)

;;;; Rainbow Mode & Delimiters (pretty colors!!)
(require 'rainbow-mode) ;; colors hex codes like a #bada55
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

;;;; Buffer cleanup
(use-package cleanup-buffer
  :bind ("C-c C-c" . bj/cleanup-buffer))

;;;; OSX Specific Settings
;; key bindings
(when (eq system-type 'darwin) ;; mac specific settings
  (setq mac-option-modifier 'alt)
  (setq mac-command-modifier 'meta)
  )

;;;; Misc. Functions
(require 'my-functions)
