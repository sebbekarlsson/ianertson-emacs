(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/"))

(setq package-enable-at-startup nil) (package-initialize)

(setq package-refreshed-this-session nil)

(defun ensure-package (p)
  (unless (package-installed-p p)
    (progn (unless package-refreshed-this-session
             (progn (package-refresh-contents)
                    (setq package-refreshed-this-session t)))
           (package-install p))))

(defun use-package (p) (progn (ensure-package p) (require p)))

; font
(set-face-attribute 'default nil :height 136)


; plugins
;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Enable Evil
(require 'evil)
(evil-mode 1)

;; --- Auto-Completion ---
(add-to-list 'load-path "~/.emacs.d/ianertson-emacs/company-mode")
(use-package 'company)
(require 'cc-mode)
(global-company-mode)
;(electric-pair-mode t)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-clang-executable "/usr/bin/clang-9")
(setq company-backends (delete 'company-semantic company-backends))
(setq company-minimum-prefix-length 2)

;(define-key c-mode-base-map  [(tab "SPC")] 'company-complete)
;(define-key c++-mode-map  [(tab "SPC")] 'company-complete)
;(global-set-key (kbd "<tab>") #'proced)
(global-set-key (kbd "TAB") #'indent-for-tab-command)


(add-to-list 'load-path "~/.emacs.d/ianertson-emacs/all-the-icons.el/")
(require 'all-the-icons)


(add-to-list 'load-path "~/.emacs.d/ianertson-emacs/emacs-neotree")
(require 'neotree)
(global-unset-key "\M-t")
(global-set-key "\M-t" 'neotree-toggle)
(setq neo-smart-open t)
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
(evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
(evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
(evil-define-key 'normal neotree-mode-map (kbd "r") 'neotree-refresh)
(evil-define-key 'normal neotree-mode-map (kbd "n") 'neotree-next-line)
(evil-define-key 'normal neotree-mode-map (kbd "p") 'neotree-previous-line)
(evil-define-key 'normal neotree-mode-map (kbd "A") 'neotree-stretch-toggle)
(evil-define-key 'normal neotree-mode-map (kbd "H") 'neotree-hidden-file-toggle)

;; --- Make escape work as expected ---
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'abort-recursive-edit)
(define-key minibuffer-local-ns-map [escape] 'abort-recursive-edit)
(define-key minibuffer-local-completion-map [escape] 'abort-recursive-edit)
(define-key minibuffer-local-must-match-map [escape] 'abort-recursive-edit)
(define-key minibuffer-local-isearch-map [escape] 'abort-recursive-edit)

(setq path-to-ctags "/usr/bin/ctags")
(defun create-tags (dir-name)
  (when (and (stringp buffer-file-name)
             (string-match "\\.c\\'" buffer-file-name))
    "Create tags file."
    (interactive "DDirectory: ")
    (  shell-command
      (format "%s -f TAGS -e -R %s" path-to-ctags (directory-file-name dir-name)))
    ))


(defun er-refresh-etags (&optional extension)
  "Run etags on all peer files in current dir and reload them silently."
  (interactive)
  (shell-command (format "etags *.%s" (or extension "c")))
  (let ((tags-revert-without-query t))  ; don't query, revert silently          
    (visit-tags-table default-directory nil)))

(global-auto-revert-mode -1)
(setq revert-without-query '(".*"))
(add-hook 'find-file-hook (lambda () (create-tags (file-name-directory (or load-file-name buffer-file-name)))))

(global-set-key (kbd "<M-left>") 'windmove-left)
(global-set-key (kbd "<M-right>") 'windmove-right)
(global-set-key (kbd "<M-up>") 'windmove-up)
(global-set-key (kbd "<M-down>") 'windmove-down)

(load-file "~/.emacs.d/ianertson-emacs/dash.el")
(load-file "~/.emacs.d/ianertson-emacs/autothemer.el")

; hide scrollbars
(add-to-list 'default-frame-alist
             '(vertical-scroll-bars . nil))

; hide menu
(tool-bar-mode -1)
(menu-bar-mode -1) 
(toggle-scroll-bar -1)

; theme
(setq sml/no-confirm-load-theme t)
(add-to-list 'load-path "~/.emacs.d/ianertson-emacs/themes/")
(add-to-list 'custom-theme-load-path "~/.emacs.d/ianertson-emacs/themes/")
(load-theme 'gruvbox t)


; etc

(setq-default c-basic-offset 2)
(setq c-default-style "linux"
      c-basic-offset 2)

(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)
