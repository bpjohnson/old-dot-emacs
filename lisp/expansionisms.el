;;YASnippet and Company expansions/snippets/autocomplete/etc.

(defvar company-mode/enable-yas t
  "Enable yasnippet for all backends.")

(defun company-mode/backend-with-yas (backend)
  (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
      backend
    (append (if (consp backend) backend (list backend))
            '(:with company-yasnippet))))


(use-package company
  :defer nil
  :diminish company-mode
  :init (progn
	  (add-hook 'prog-mode-hook 'company-mode)
	  (add-hook 'org-mode-hook 'company-mode)
	  )
  :config (progn
	    (setq company-idle-delay 0.1
		  company-minimum-prefix-length 2
		  company-selection-wrap-around t
		  company-show-numbers t
		  ;;company-transformers '(company-sort-by-occurance)
		  )
	    (setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))
	    (bind-keys :map company-active-map
		       ("C-n" . company-select-next)
		       ("C-p" . company-select-previous)
		       ("C-d" . company-show-doc-buffer)
		       ("<tab>" . company-complete)
		       )
	    
	    )
  )

(use-package yasnippet
  :diminish yas-minor-mode
  :mode ("/\\.emacs\\.d/snippets/" . snippet-mode)
  :init (progn
	  (setq yas-verbosity 3)
	  (yas-global-mode 1)
	  )
  )

(use-package react-snippets
 :demand t)


(provide 'expansionisms)
