(use-package projectile
  :load-path "lisp/projectile"
  :ensure nil
  :diminish projectile-mode
  )

(use-package perspective)

(use-package nameframe
  :load-path "lisp/nameframe"
  :ensure nil
  :config
  (progn
    (projectile-global-mode)
    (persp-mode)
    (require 'persp-projectile)
    (require 'nameframe-projectile)
    (require 'nameframe-perspective)
    (nameframe-projectile-mode t)
    (nameframe-perspective-mode t)
    )
  :bind (
	 ("M-p" . nameframe-switch-frame)
	 ("M-o" . projectile-persp-switch-project)
	 )
  ); end nameframe use-package


(provide 'projectstuff)
