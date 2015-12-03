;;json mode (separate from js2-mode)
(use-package json-mode
 :mode "\\.json$"
 )

;;;web mode for html, php and jsx
(use-package web-mode
 :config
 (progn
   (rainbow-mode)
   (setq web-mode-markup-indent-offset 2)
   (setq web-mode-css-indent-offset 2)
   (setq web-mode-code-indent-offset 2)
   (defadvice web-mode-highlight-part (around tweak-jsx activate)
     (if (equal web-mode-content-type "jsx")
	 (let ((web-mode-enable-part-face nil))
	   ad-do-it)
       ad-do-it))
   )
 :init
 (progn
   (setq web-mode-engines-alist
	 '(
	   ("php" . "\\.inc")
	   ("php" . "\\.ihtml")
	   ("meteor" . "\\.html\\'")
	   )
	 )
   )
 :mode
 (
  ("\\.php$" . web-mode)
  ("\\.ihtml$" . web-mode)
  ("\\.inc$" . web-mode)
  ("\\.html$" . web-mode)
  ("\\.tpl$" . web-mode)
  ("\\.jsx$" . web-mode)
  ("\\.css$" . web-mode)
  ("\\.scss$" . web-mode)
  )
 )

(use-package js2-mode
  :mode "\\.js$"
  :diminish "js"
 )

(use-package coffee-mode
 :mode "\\.coffee$"
 :init
 (progn
   ;; This gives you a tab of 2 spaces
   (custom-set-variables '(coffee-tab-width 2))
   )
 )

;;; The following are more programming utilities than actual programming modes.

;;;Show a guide to the current indentation level. I use it specifically for coffee-mode.
(use-package indent-guide
 :init
 (progn
   (add-hook 'coffee-mode-hook 'indent-guide-mode)
   )
 )

;;;Automatically highlight TODO: and FIXME
(defun font-lock-comment-annotations ()
  "Highlight a bunch of well known comment annotations.

This functions should be added to the hooks of major modes for programming."
  (font-lock-add-keywords
   nil '(("\\<\\(FIX\\(ME\\)?\\|TODO\\|OPTIMIZE\\|HACK\\|REFACTOR\\):?"
          1 font-lock-warning-face t))))

(add-hook 'prog-mode-hook 'font-lock-comment-annotations)

;;;Rainbow Mode shows hexcodes as colors
(use-package rainbow-mode)

(use-package rainbow-delimiters
 :init
 (progn
   (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
   )
 )

(use-package multi-line
 :bind ("C-d" . multi-line))

;;editorconfig https://github.com/editorconfig/editorconfig-emacs#readme
(use-package editorconfig
  :disabled t
  :init
  (progn
    (add-hook 'prog-mode-hook #'editorconfig-mode)
    )
  )

;;;Subword mode is builtin, but makes forward-word and backward-word understand camelcase
(global-subword-mode)
(diminish 'subword-mode)


(provide 'programmerer)
