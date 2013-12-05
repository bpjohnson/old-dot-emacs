(defun cleanup-buffer-safe ()
  "Perform a bunch of safe operations on the whitespace content of a buffer.
Does not indent buffer, because it is used for a before-save-hook, and that
might be bad."
  (interactive)
  (message "Untabifying Buffer")
  (untabify-buffer)
  (message "Deleting Trailing Whitespace")
  (delete-trailing-whitespace)
  (set-buffer-file-coding-system 'utf-8))

(defun bj/cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer.
Including indent-buffer, which should not be called automatically on save."
  (interactive)
  (cleanup-buffer-safe)
  (message "Indenting Buffer")
  (indent-buffer)
  (message "Buffer should now be clean."))

(defun untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))

(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun indent-defun ()
  "Indent the current defun."
  (interactive)
  (save-restriction
    (widen)
    (narrow-to-defun)
    (indent-buffer)))

;; Trailing whitespace is unnecessary
(add-hook 'before-save-hook 'cleanup-buffer-safe)


(provide 'cleanup-buffer)
