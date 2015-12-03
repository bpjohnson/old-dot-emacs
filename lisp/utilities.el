(use-package smartparens-config
  :ensure smartparens
  :init
  (progn
    (smartparens-global-mode)
    (show-smartparens-global-mode t)
    (diminish 'smartparens-mode)
    (eval-after-load "web-mode" '(setq web-mode-enable-auto-pairing nil)) ;; compat
    )
  :config
  (progn
    ;; From https://ebzzry.github.io/emacs-pairs.html
    (defmacro def-pairs (pairs)
      `(progn
	 ,@(loop for (key . val) in pairs
		 collect
		 `(defun ,(read (concat
				 "wrap-with-"
				 (prin1-to-string key)
				 "s"))
		      (&optional arg)
		    (interactive "p")
		    (sp-wrap-with-pair ,val)))))

    (def-pairs ((paren        . "(")
		(bracket      . "[")
		(brace        . "{")
		(single-quote . "'")
		(double-quote . "\"")
		(underscore . "_")
		(back-quote   . "`")))

    
    (bind-keys :map sp-keymap
	       ("C-<down>" . sp-down-sexp)
		("C-<up>"   . sp-up-sexp)
		("M-<down>" . sp-backward-down-sexp)
		("M-<up>"   . sp-backward-up-sexp)
					;("C-<right>" . sp-forward-slurp-sexp)
					;("M-<right>" . sp-forward-barf-sexp)
					;("C-<left>"  . sp-backward-slurp-sexp)
					;("M-<left>"  . sp-backward-barf-sexp)
		("C-c ("  . wrap-with-parens)
		("C-c ["  . wrap-with-brackets)
		("C-c {"  . wrap-with-braces)
		("C-c '"  . wrap-with-single-quotes)
		("C-c \"" . wrap-with-double-quotes)
		("C-c _"  . wrap-with-underscores)
		("C-c `"  . wrap-with-back-quotes)
		)
    )
  )


(use-package multiple-cursors
  :bind (
	 ("C->" . mc/mark-next-like-this)
	 ("C-<" . mc/mark-previous-like-this)
	 ("C-c C-<" . mc/mark-all-like-this)
	 )
  )

(use-package expand-region
  :bind ("C-=" . er/expand-region)
 )

(use-package swiper
  :demand t
  :config (progn
	    (bind-keys*
	     ("C-s" . swiper)
	     ("C-c C-r" . ivy-resume)
	     ))
 )

(use-package ido
  :init
  (progn
  (ido-mode 1)
  (setq ido-default-buffer-method 'selected-window)
  (add-hook 'ido-make-file-list-hook 'ido-sort-mtime)
  (add-hook 'ido-make-dir-list-hook 'ido-sort-mtime)
  (defun ido-sort-mtime ()
    (setq ido-temp-list
          (sort ido-temp-list
                (lambda (a b)
                  (let ((ta (nth 5 (file-attributes (concat ido-current-directory a))))
                        (tb (nth 5 (file-attributes (concat ido-current-directory b)))))
                    (if (= (nth 0 ta) (nth 0 tb))
                        (> (nth 1 ta) (nth 1 tb))
                      (> (nth 0 ta) (nth 0 tb)))))))
    (ido-to-end  ;; move . files to end (again)
     (delq nil (mapcar
                (lambda (x) (if (string-equal (substring x 0 1) ".") x))
                ido-temp-list)))))
  :config
  (progn
    (add-to-list 'ido-ignore-files "\\.DS_Store")
    )
  )


(use-package smex
  :bind (
	 ("M-x" . smex)
	 ("M-X" . smex-major-mode-commands)
	 ("C-c C-c M-x" . execute-extended-command)
	 )
  )


(provide 'utilities)