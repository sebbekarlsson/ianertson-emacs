(defun get-string-from-file (filePath)
  "Return filePath's file content."
  (with-temp-buffer
    (insert-file-contents filePath)
    (buffer-string)))


(setq basepath "~/.emacs.d/ianertson-emacs/snippets/")

(defun insertsnippet (a)
  (interactive "s: ")
  (insert (funcall 'get-string-from-file (concat basepath a))))
