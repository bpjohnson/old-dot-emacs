;;; My Customized Settings
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-safe-themes
   (quote
    ("ef36e983fa01515298c017d0902524862ec7d9b00c28922d6da093485821e1ba" default)))
 '(ecb-layout-window-sizes
   (quote
    (("left15"
      (ecb-directories-buffer-name 0.17647058823529413 . 0.45454545454545453)
      (ecb-methods-buffer-name 0.17647058823529413 . 0.5272727272727272)))))
 '(ecb-non-semantic-parsing-function (quote ((js3-mode . speedbar-fetch-dynamic-imenu))))
 '(ecb-options-version "2.40")
 '(ecb-process-non-semantic-files t)
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(initial-major-mode (quote org-mode))
 '(js3-global-externs (quote ("$" "Ext")))
 '(scss-compile-at-save nil)
 '(tabbar-ruler-invert-deselected nil)
 '(tool-bar-mode nil)
 '(wakatime-api-key "7651e7d7-4e8d-4b08-89b2-d17f22f0e75e")
 '(wakatime-cli-path
   #("/usr/local/bin/wakatime" 1 5
     (face flx-highlight-face)
     5 10
     (face flx-highlight-face)
     11 15
     (face flx-highlight-face)))
 '(web-mode-enable-current-element-highlight t))



(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flx-highlight-face ((t (:box (:line-width 1 :color "grey75" :style released-button) :weight bold))))
 '(tabbar-unselected ((t (:inherit nil :stipple nil :background "gray88" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 128 :width normal))))
 '(web-mode-current-element-highlight-face ((t (:background "#ffff88" :weight bold)))))
