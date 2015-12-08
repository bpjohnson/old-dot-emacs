(use-package which-key
  :init (which-key-mode)
  :config (progn
	    (which-key-setup-minibuffer)
	    )
  )

(use-package cheatsheet
  :bind ("<f12>" . cheatsheet-show)
  :config (progn
	    ;;Add Cheatsheet entries here.
	    (cheatsheet-add :group 'Notes
                :key "C-c c p"
                :description "Add Project Todo")
	    )
  )

(provide 'learning)
