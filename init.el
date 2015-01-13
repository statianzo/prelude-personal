(require 'simplezen)

(defun comment-region-or-line ()
    "Comments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-region beg end)))

(defun uncomment-region-or-line ()
    "Uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (uncomment-region beg end)))

(define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
(cl-loop for (mode . state) in '((inferior-emacs-lisp-mode . emacs)
                                 (fundamental-mode . normal)
                                 (package-menu-mode . normal)
                                 (nav-mode . emacs)
                                 (pylookup-mode . emacs)
                                 ;; CIDER modes
                                 (cider-docview-mode . emacs)
                                 (cider-inspector-mode . emacs)
                                 (cider-macroexpansion-mode . emacs)
                                 (cider-repl-mode . emacs)
                                 (cider-result-mode . emacs)
                                 (cider-stacktrace-mode . emacs)
                                 (cider-test-report-mode . emacs)

                                 (comint-mode . emacs)
                                 (ebib-entry-mode . emacs)
                                 (ebib-index-mode . emacs)
                                 (ebib-log-mode . emacs)
                                 (eshell-mode . emacs)
                                 (elfeed-show-mode . emacs)
                                 (elfeed-search-mode . emacs)
                                 (ensime-inf-mode . emacs)
                                 (gtags-select-mode . emacs)
                                 (git-commit-mode . emacs)
                                 (git-rebase-mode . emacs)
                                 (dired-mode . emacs)
                                 (shell-mode . emacs)
                                 (term-mode . emacs)
                                 (text-mode . normal)
                                 (bc-menu-mode . emacs)
                                 (magit-status-mode . emacs)
                                 (magit-branch-manager-mode . emacs)
                                 (semantic-symref-results-mode . emacs)
                                 (rdictcc-buffer-mode . emacs)
                                 (erc-mode . normal))
         do (evil-set-initial-state mode state))

;; Window switching
(define-key evil-normal-state-map (kbd "C-l") 'windmove-right)
(define-key evil-normal-state-map (kbd "C-h") 'windmove-left)
(define-key evil-normal-state-map (kbd "C-j") 'windmove-down)
(define-key evil-normal-state-map (kbd "C-k") 'windmove-up)
(define-key evil-normal-state-map (kbd "C-p") 'projectile-find-file)
(define-key evil-normal-state-map (kbd "C-S-p") 'projectile-find-file-other-window)

(define-key evil-normal-state-map ",n" 'neotree-toggle)
(define-key evil-normal-state-map ",m" 'neotree-find)
(define-key evil-normal-state-map ",cc" 'comment-region-or-line)
(define-key evil-normal-state-map ",cu" 'uncomment-region-or-line)
(define-key evil-visual-state-map ",cc" 'comment-region-or-line)
(define-key evil-visual-state-map ",cu" 'uncomment-region-or-line)

(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

(scroll-bar-mode -1)
(global-set-key (kbd "C-p") 'projectile-find-file)
(global-set-key (kbd "C-S-p") 'projectile-find-file-other-window)
(setq projectile-switch-project-action 'neotree-projectile-action)


(add-hook 'neotree-mode-hook
          (lambda ()
            (define-key evil-normal-state-local-map (kbd "TAB") 'neotree-enter)
            (define-key evil-normal-state-local-map (kbd "SPC") 'neotree-enter)
            (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
            (define-key evil-normal-state-local-map (kbd "r") 'neotree-refresh)
            (define-key evil-normal-state-local-map (kbd "I") 'neotree-hidden-file-toggle)
            (define-key evil-normal-state-local-map (kbd "D") 'neotree-delete-node)
            (define-key evil-normal-state-local-map (kbd "C") 'neotree-create-node)
            (define-key evil-normal-state-local-map (kbd "R") 'neotree-rename-node)
            (define-key evil-normal-state-local-map (kbd "RET") 'neotree-enter)))


(defun my-move-key (keymap-from keymap-to key)
  "Moves key binding from one keymap to another, deleting from the old location. "
  (define-key keymap-to key (lookup-key keymap-from key))
  (define-key keymap-from key nil))
(my-move-key evil-motion-state-map evil-normal-state-map (kbd "RET"))
(my-move-key evil-motion-state-map evil-normal-state-map " ")
(my-move-key evil-motion-state-map evil-normal-state-map (kbd "C-b"))
(add-hook 'ruby-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))

(setq c-basic-offset 2)
(setq default-tab-width 2)
(setq js-indent-level 2)
(setq ruby-indent-level 2)
(setq web-mode-code-indent-offset 2)
(setq-default indent-tabs-mode nil)
(setq tab-width 2)
(add-hook 'js2-mode-hook
          (lambda ()
            (setq
             js2-basic-offset 2
             tab-width 2
             indent-tabs-mode nil
             js2-auto-insert-semicolon t)))

(add-hook 'web-mode-hook
          (lambda ()
            (setq
             web-mode-markup-indent-offset 2
             web-mode-code-indent-offset 2
             web-mode-css-indent-offset 2
             web-mode-enable-auto-pairing t
             web-mode-enable-auto-closing t
             web-mode-enable-auto-opening t
             )))

(add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode))

(disable-theme 'zenburn)
(load-theme 'wombat)
(hl-line-mode -1)
(global-hl-line-mode -1)
(setq evil-want-C-i-jump t)
(add-hook 'evil-mode-hook
          (turn-on-evil-jumper-mode))
(add-hook 'text-mode-hook
          (turn-on-evil-mode))

(add-hook 'package-menu-mode-hook
          (lambda ()
            (define-key evil-normal-state-local-map (kbd "i") 'package-menu-mark-install)
            (define-key evil-normal-state-local-map (kbd "u") 'package-menu-mark-unmark)
            (define-key evil-normal-state-local-map (kbd "U") 'package-menu-mark-upgrades)
            (define-key evil-normal-state-local-map (kbd "d") 'package-menu-mark-delete)
            (define-key evil-normal-state-local-map (kbd "r") 'package-menu-refresh)
            (define-key evil-normal-state-local-map (kbd "x") 'package-menu-execute)
            (define-key evil-normal-state-local-map (kbd "RET") 'package-menu-describe-package)))

(defun my-move-key (keymap-from keymap-to key)
  "Moves key binding from one keymap to another, deleting from the old location. "
  (define-key keymap-to key (lookup-key keymap-from key))
  (define-key keymap-from key nil))
(my-move-key evil-motion-state-map evil-normal-state-map (kbd "RET"))
(my-move-key evil-motion-state-map evil-normal-state-map " ")
(my-move-key evil-motion-state-map evil-normal-state-map (kbd "C-b"))
(add-hook 'ruby-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))

(setq c-basic-offset 2)
(setq default-tab-width 2)
(setq js-indent-level 2)
(setq ruby-indent-level 2)
(setq web-mode-code-indent-offset 2)
(setq-default indent-tabs-mode nil)
(setq tab-width 2)
(add-hook 'js2-mode-hook
          (lambda ()
            (setq
             js2-basic-offset 2
             tab-width 2
             indent-tabs-mode nil
             js2-auto-insert-semicolon t)))

(add-hook 'web-mode-hook
          (lambda ()
            (setq
             web-mode-markup-indent-offset 2
             web-mode-code-indent-offset 2
             web-mode-css-indent-offset 2
             web-mode-enable-auto-pairing t
             web-mode-enable-auto-closing t
             web-mode-enable-auto-opening t
             )
            (define-key evil-insert-state-local-map (kbd "TAB") 'simplezen-expand-or-indent-for-tab)
            ))

(add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode))

(disable-theme 'zenburn)
(load-theme 'wombat)
(hl-line-mode -1)
(global-hl-line-mode -1)
(setq evil-want-C-i-jump t)
(add-hook 'evil-mode-hook
          (turn-on-evil-jumper-mode))
(add-hook 'text-mode-hook
          (turn-on-evil-mode))
