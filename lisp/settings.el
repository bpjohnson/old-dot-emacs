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

;; store all backup and autosave files a backup dir
(setq backup-directory-alist '(("" . "~/.emacs.d/backups")))
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default t)
(setq backup-inhibited t)

;; Autosafe actual buffers instead of making backups
(defun save-buffer-if-visiting-file (&optional args)
  "Save the current buffer only if it is visiting a file"
  (interactive)
  (if (buffer-file-name)
      (save-buffer args)))

;; This causes files that I'm editing to be saved automatically by the
;; emacs auto-save functionality.  I'm hoping to break myself of the
;; c-x c-s twitch.
(add-hook 'auto-save-hook 'save-buffer-if-visiting-file)

;; save every 20 characters typed (this is the minimum)
(setq auto-save-interval 20)

;; save after 1 second of idle time (default is 30)
(setq auto-save-timeout 1)


(defvar bj/dropbox-directory ""
  "Base Dropbox Directory, set per machine.")


(setq custom-file "~/.emacs.d/lisp/custom.el")
(load custom-file)

(provide 'settings)
