(use-package which-key
  :init (which-key-mode)
  :config (progn
            (which-key-setup-minibuffer)
            )
  )

(use-package cheatsheet
  :bind ("<f12>" . cheatsheet-show)
  :config
  (progn
    ;;Add Cheatsheet entries here.
    (cheatsheet-add
     :group 'Projects
     :key "C-c p p"
     :description "Create New Project")
    (cheatsheet-add
     :group 'Projects
     :key "M-o"
     :description "Open Project")
    (cheatsheet-add
     :group 'Projects
     :key "M-p"
     :description "Switch Project Window")
    (cheatsheet-add
     :group 'Projects
     :key "C-c c p"
     :description "Add Project Todo")
    (cheatsheet-add
     :group 'Multi-Cursor
     :key "C->"
     :description "Mark Next")
    (cheatsheet-add
     :group 'Multi-Cursor
     :key "C-<"
     :description "Mark Prev")
    (cheatsheet-add
     :group 'Multi-Cursor
     :key "C-c C-<"
     :description "Mark All")
    (cheatsheet-add
     :group 'Parens
     :key "M-<up>"
     :description "Move Up Sexp")
    (cheatsheet-add
     :group 'Parens
     :key "M-<down>"
     :description "Move Down Sexp")
    (cheatsheet-add
     :group 'Parens
     :key "C-c ("
     :description "Wrap Selection")
    (cheatsheet-add
     :group 'Parens
     :key "C-d"
     :description "Multiline Sexp")
    )
  )

(provide 'learning)
