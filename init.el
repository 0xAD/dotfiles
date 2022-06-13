;; OSX Hooks
(setq x-alt-keysym 'meta)

(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)

;; Changes all yes/no questions to y/n type
(fset 'yes-or-no-p 'y-or-n-p)

;; No need for ~ files when editing
(setq create-lockfiles nil)

(menu-bar-mode -1)
;;(tool-bar-mode -1)


;; Editing Hooks
(setq-default indent-tabs-mode t)

(setq default-tab-width 8)
(setq tab-width 8)
(setq-default c-basic-offset 8
              tab-width 8)

;; Show line numbers
(global-linum-mode)

(setq column-number-mode t)

(require 'saveplace)
(setq-default save-place t)
;; keep track of saved places in ~/.emacs.d/places
(setq save-place-file (concat user-emacs-directory "places"))

;; Emacs can automatically create backup files. This tells Emacs to
;; put all backups in ~/.emacs.d/backups. More info:
;; http://www.gnu.org/software/emacs/manual/html_node/elisp/Backup-Files.html
(setq backup-directory-alist `(("." . ,(concat user-emacs-directory
                                               "backups"))))
(setq auto-save-default nil)

(setq split-height-threshold 1200)
(setq split-width-threshold 2000)

;; This section defines commands and shortcuts to tune text size.
;; The text size changes will affect all buffers.
(setq text-size-default 130) ;; old value 134
(setq text-size-current text-size-default)
(setq text-size-step 10)

;; increase font size for better readability
(set-face-attribute 'default nil :height text-size-default) 

(defun text-size-set (value)
  (setq text-size-current value)
  (set-face-attribute 'default nil :height text-size-current)
  (message "new text size is %d:" text-size-current)
  )

(defun text-size-increase (l)
  "increases the text size by text-size-step"
  (interactive "p")
  (text-size-set (+ text-size-current text-size-step))
  )

(defun text-size-decrease (l)
  "increases the text size by text-size-step"
  (interactive "p")
  (text-size-set (- text-size-current text-size-step))
  )

(defun text-size-reset (l)
  "resets the text size to default"
  (interactive "p")
  (text-size-set text-size-default)
  )

;; define keyboard shortcuts as it works natively on Mac apps
(global-set-key (kbd "s-+") 'text-size-increase) ;; increase size
(global-set-key (kbd "s-=") 'text-size-increase) ;; also increase size
(global-set-key (kbd "s--") 'text-size-decrease) ;; decrease size
(global-set-key (kbd "s-_") 'text-size-decrease) ;; also decrease size
(global-set-key (kbd "s-0") 'text-size-reset)    ;; reset size

(setq scroll-preserve-screen-position 1)
(global-set-key (kbd "M-n") (kbd "C-u 10 C-v"))
(global-set-key (kbd "M-p") (kbd "C-u 10 M-v"))

;; Go straight to scratch buffer on startup
(setq inhibit-startup-message t)

;;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;;(add-to-list 'load-path "~/.emacs.d/themes")
;;(load-theme 'tomorrow-night t)

(global-font-lock-mode 1)

(setq str-com-grey "#555555")

(set-face-foreground 'font-lock-function-name-face "black")
(set-face-attribute  'font-lock-function-name-face nil :weight 'semi-bold)
(set-face-foreground 'font-lock-variable-name-face "black")
(set-face-foreground 'font-lock-keyword-face "black")

(set-face-foreground 'font-lock-comment-face str-com-grey)
(set-face-foreground 'font-lock-comment-delimiter-face str-com-grey)

(set-face-foreground 'font-lock-type-face "black")
;;(set-face-attribute  'font-lock-type-face nil :weight 'semi-bold)

(set-face-foreground 'font-lock-constant-face "black")
(set-face-foreground 'font-lock-builtin-face "black")
(set-face-foreground 'font-lock-preprocessor-face "black")
(set-face-foreground 'font-lock-string-face str-com-grey)
(set-face-foreground 'font-lock-doc-face "black")
(set-face-foreground 'font-lock-negation-char-face "black")

(add-to-list 'default-frame-alist '(background-color . "#FFFFEA"))

(add-to-list 'default-frame-alist '(background-color . "#DDDDE4"))

(set-face-foreground 'linum "#375f41")
(setq linum-format "%4d\u2502 ")

(add-hook 'rust-mode-hook
	  (lambda () (setq indent-tabs-mode nil)))

(add-hook 'rust-mode-hook #'lsp)

; list the packages you want
(setq package-list '(smex magit rust-mode projectile lsp-mode company))

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

; activate all the packages (in particular autoloads)
(package-initialize)

; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(global-set-key (kbd "C-x v b") 'vc-git-grep)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(company lsp-mode projectile rust-mode magit smex)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
