;;Welcome to my Emacs.

;;Always start new frames maximized (not fullboth)
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Require Emacs' package functionality
(require 'package)

;; Add the Melpa repository to the list of package sources
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
;; And marmalade
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

;; Initialise the package system.
(package-initialize)

(require 'use-package)
(setq use-package-always-ensure t) ;; always install packages using package.el
                                   ;; this means local packages need ":ensure nil"

(use-package settings ;; Non-package global settings. Also customize settings
  :load-path "lisp/"
  :ensure nil)

(use-package visual
 :load-path "lisp/"
 :ensure nil)

(use-package osx-customizations
  :load-path "lisp/"
  :ensure nil
  :if (eq system-type 'darwin)
  )

(use-package learning ;; Packages that help me learn emacs more (which-key, etc)
  :load-path "lisp/"
  :ensure nil)


(use-package expansionisms ;; YASnippet and Company expansions/snippets/autocomplete/etc.
  :load-path "lisp/"
  :ensure nil)

;; Various utility packages for Emacs
;; expand-region, multiple-cursors, smartparens, ido, smex, swiper
(use-package utilities
  :load-path "lisp/"
  :ensure nil)

;; Project Management stuff. (projectile, perspective, nameframe)
(use-package projectstuff
  :ensure nil
  :load-path "lisp/")

;;Programming modes & utilities 
(use-package programmerer
  :ensure nil
  :demand t
  :load-path "lisp/")

;; Misc unpackaged functions
(use-package myfun
  :load-path "lisp/"
  :ensure nil
  :bind
  (
   ("C-c C-c" . bj/cleanup-buffer)
   ("M-g g" . goto-line-with-feedback)
   )
  )
