;;Org eXport TWitter BootStrap. Too many acronyms.
;; https://github.com/marsmining/ox-twbs
(use-package ox-twbs
					;:disabled t
  :config
  (progn
    (use-package htmlize
      :demand t
      )
    ;(use-package org-plus-contrib
    ;  :demand t
    ;  )
    (require 'ox-rss)
    )
  :init
  (progn
    (setq org-html-htmlize-output-type 'css)
    (setq org-publish-project-alist
          `(
            (
             "debuggery-static"
             :base-directory ,(concat (file-name-as-directory bj/dropbox-directory) "/Blogs/debuggery/static/")    ; directory where images are stored
             :base-extension "png\\|jpg\\|gif\\|css\\|js"           ; images extensions
             :publishing-directory ,(concat (file-name-as-directory bj/dropbox-directory) "/Blogs/debuggery/html/")      ; directory where to move (publish) images
             :publishing-function org-publish-attachment
             :recursive t
             );end static
            (
             "debuggery-pages"
	     :base-directory "~/Projects/debuggery/"
	     :base-extension "org"
	     :publishing-directory "~/Projects/debuggery/_site"
	     :publishing-function org-twbs-publish-to-html
	     :htmlized-source t ;; this enables htmlize, which means that I can use css for code!

	     :with-author nil
	     :with-creator nil
	     :with-date nil
	     :with-email nil      ; Disable the inclusion of "(your email)" in the postamble.
	     :headline-level 4
	     :section-numbers nil
	     :with-toc nil
	     :with-drawers t
	     :with-sub-superscript nil ;; important!!

	     :html-format-drawer-function my-blog-org-export-format-drawer

	     ;; sitemap - list of blog articles
	     :auto-sitemap t
	     :sitemap-filename "index.org"
	     :sitemap-title "Debuggery"
	     ;; custom sitemap generator function
	     :sitemap-function my-blog-sitemap
	     :sitemap-sort-files anti-chronologically
	     :sitemap-date-format "Published: %a %b %d %Y"

	     :recursive t
	     :headline-numbering nil

	     :auto-postamble nil
	     :html-postamble nil

             :with-author nil       ; Enable the inclusion of "Author: Your Name" in the postamble.
             :with-date nil
					; :exclude "index.org\\|rss.org"
             ;:exclude-tags ("draft")
             );end pages
            (
             "debuggery"
             :components (
                                        ;"debuggery-posts"
                          "debuggery-static"
                          "debuggery-pages"
                          )
             );end blog debuggery
            ); end alist
          ); end setq


    (defun auto-publish-blog-hook ()
      "Auto publish blog on save"
      ;; check if saved file is part of blog
      (if (org-publish-get-project-from-filename
           (buffer-file-name (buffer-base-buffer)) 'up)
          (save-excursion (org-publish-current-file)
                          (message "Auto published blog.") nil)))

    ;; Enable auto-publish when a org file in blog is saved
    (add-hook 'org-mode-hook
              (lambda ()
                (add-hook 'after-save-hook 'auto-publish-blog-hook nil nil)))
    )
  )

(defun my-blog-org-export-format-drawer (name content)
  (concat "<div class=\"panel panel-default " (downcase name) "\">
  <div class=\"panel-heading\">
    <h3 class=\"panel-title\">" (capitalize name) "</h3>
  </div>
  <div class=\"panel-body\">
    " content "
  </div>
</div>"))

(defun my-blog-sitemap (project &optional sitemap-filename)
  "Generate the sitemap for my blog."
  (message "Generating blog sitemap")
  (let* ((project-plist (cdr project))
         (dir (file-name-as-directory
               (plist-get project-plist :base-directory)))
         (localdir (file-name-directory dir))
         (exclude-regexp (plist-get project-plist :exclude))
         (files (nreverse
                 (org-publish-get-base-files project exclude-regexp)))
         (sitemap-filename (concat dir (or sitemap-filename "sitemap.org")))
         (sitemap-sans-extension
          (plist-get project-plist :sitemap-sans-extension))
         (visiting (find-buffer-visiting sitemap-filename))
         file sitemap-buffer)
    (with-current-buffer
        (let ((org-inhibit-startup t))
          (setq sitemap-buffer
                (or visiting (find-file sitemap-filename))))
      (erase-buffer)
      ;; loop through all of the files in the project
      (while (setq file (pop files))
        (let ((fn (file-name-nondirectory file))
              (link ;; changed this to fix links. see postprocessor.
               (file-relative-name file (file-name-as-directory
                                         (expand-file-name (concat (file-name-as-directory dir) "..")))))
              (oldlocal localdir))
          (when sitemap-sans-extension
            (setq link (file-name-sans-extension link)))
          ;; sitemap shouldn't list itself
          (unless (equal (file-truename sitemap-filename)
                         (file-truename file))
            (let (;; get the title and date of the current file
                  (title (org-publish-format-file-entry "%t" file project-plist))
                  (date (org-publish-format-file-entry "%d" file project-plist))
                  ;; get the preview section from the current file
                  (preview (my-blog-get-preview file))
                  (regexp "\\(.*\\)\\[\\([^][]+\\)\\]\\(.*\\)"))
              ;; insert a horizontal line before every post, kill the first one
              ;; before saving
	      (insert "-----\n")
              (cond ((string-match-p regexp title)
                     (string-match regexp title)
                     ;; insert every post as headline
                     (insert (concat"* " (match-string 1 title)
                                    "[[file:" link "]["
                                    (match-string 2 title)
                                    "]]" (match-string 3 title) "\n")))
                    (t (insert (concat "* [[file:" link "][" title "]]\n"))))
              ;; add properties for `ox-rss.el' here
              (let ((rss-permalink (concat (file-name-sans-extension link) ".html"))
                    (rss-pubdate (format-time-string
                                  (car org-time-stamp-formats)
                                  (org-publish-find-date file))))
                (org-set-property "RSS_PERMALINK" rss-permalink)
                (org-set-property "PUBDATE" rss-pubdate))
              ;; insert the date, preview, & read more link
              (insert (concat date "\n\n"))
              (insert preview)
              (insert (concat "[[file:" link "][Read More...]]\n"))))))
      ;; kill the first hrule to make this look OK
      (goto-char (point-min))
      (let ((kill-whole-line t)) (kill-line))
      (save-buffer))
    (or visiting (kill-buffer sitemap-buffer))))

(defun my-blog-get-preview (file)
  "The comments in FILE have to be on their own lines, prefereably before and after paragraphs."
  (with-temp-buffer
    (insert-file-contents file)
    (goto-char (point-min))
    (let ((beg (+ 1 (re-search-forward "^#\\+BEGIN_PREVIEW$")))
          (end (progn (re-search-forward "^#\\+END_PREVIEW$")
                      (match-beginning 0))))
      (buffer-substring beg end))))

(provide 'blogging)
