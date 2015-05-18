;; My Settings

;; Don't show the startup screen
(setq inhibit-startup-message t)
;; Make initial scratch buffer empty
(setq initial-scratch-message nil)
;; "y or n" instead of "yes or no"
(fset 'yes-or-no-p 'y-or-n-p)
;; Highlight regions and add special behaviors to regions.
;; "C-h d transient" for more info
(setq transient-mark-mode t)
;; Explicitly show the end of a buffer
(set-default 'indicate-empty-lines t)
;; Syntax hilight
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)
;; Highlight the current line. Always.
(global-hl-line-mode +1)
;; UTF
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
;; Auto refresh buffers
(global-auto-revert-mode 1)
;; Also auto refresh dired, but be quiet about it
(setq global-auto-revert-non-file-buffers t)
(setq auto-revert-verbose nil)
;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))


(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(provide 'settings)
