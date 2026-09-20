;; added a comment
;; for me it's something else

(package-initialize)
(setq custom-file "~/.emacs.custom.el")

(add-to-list 'default-frame-alist `(font . "JetBrainsMonoNL Nerd Font"))
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode 1)

(ido-mode 1)
(setq ido-enable-flex-matching t)
(ido-everywhere 1)
(setq make-backup-files nil)
(add-to-list 'display-buffer-alist
             '("\\*compilation\\*"
               (display-buffer-reuse-window display-buffer-at-bottom)
               (window-height . 0.33)
               (reusable-frames . visible)))

(global-set-key (kbd "M-h") 'windmove-left)
(global-set-key (kbd "M-j") 'windmove-down)
(global-set-key (kbd "M-k") 'windmove-up)
(global-set-key (kbd "M-l") 'windmove-right)

;; Set up package.el to work with MELPA
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; Download Evil
(unless (package-installed-p 'evil)
  (package-refresh-contents)
  (package-install 'evil))

;; Enable Evil
(require 'evil)
(setq evil-want-C-u-scroll t)
(setq evil-want-C-d-scroll t)
(evil-mode 1)

;; Keep a block cursor in Normal state, but change its color
(setq evil-normal-state-cursor '(box "yellow"))

;; Optional: customize other states for contrast
(setq evil-insert-state-cursor '(box "white"))
(setq evil-visual-state-cursor '(box "green"))

;; Force C-u to scroll up (half-page) in Normal and Visual states
(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up)
(define-key evil-insert-state-map (kbd "C-v") 'clipboard-yank)

;;Also bind it in the motion state map (used by some special modes like Dired or Help)
(define-key evil-motion-state-map (kbd "C-u") 'evil-scroll-up)

;; Ido
(global-set-key (kbd "C-c p") 'ido-find-file)

(load-file "~/.emacs.rc/rc.el")
(rc/require-theme 'gruber-darker)

(add-to-list 'load-path "~/.emacs.local")
(require 'simpc-mode)
(require 'odin-mode)

(rc/require 'smex)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;; multiple cursors
(rc/require 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this)

(defun rc/duplicate-line ()
  "Duplicate current line"
  (interactive)
  (move-beginning-of-line 1)
  (kill-line)
  (yank)
  (newline)
  (yank))

(global-set-key (kbd "C-,") 'rc/duplicate-line)
(add-to-list 'auto-mode-alist '("\\.[hc]\\(pp\\)?\\'" . simpc-mode))

(load custom-file)
