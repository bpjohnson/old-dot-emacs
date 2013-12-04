(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/"))) 

(package-initialize)
 
(defvar my-packages '(paredit auto-complete exec-path-from-shell js3-mode yasnippet autopair flx-ido scss-mode projectile))
