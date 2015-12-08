(use-package org-bullets
  :init
  (progn
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
    )
  )

(add-hook 'org-mode-hook (lambda () (variable-pitch-mode t)))

(use-package org-projectile
  :demand t
  :bind (("C-c n p" . org-projectile:project-todo-completing-read)
         ("C-c c" . org-capture))
  :config
  (progn
    (setq org-projectile:projects-file 
          (concat (file-name-as-directory bj/dropbox-directory) "Work/projects.org"))
    (setq org-agenda-files (append org-agenda-files (org-projectile:todo-files)))
    (add-to-list 'org-capture-templates (org-projectile:project-todo-entry "p")))
  :ensure t)
(provide 'org-stuff)
