(setq auto-save-interval 1
      auto-save-timeout 1
      auto-save-list-file-prefix (expand-file-name "auto-save-list" cache-dir)
      auto-save-file-name-transforms `((".*" ,cache-dir t))
      savehist-additional-variables '(kill-ring compile-command search-ring regexp-search-ring)

      backup-directory-alist `((".*" . ,cache-dir))
      backup-by-copying t    ; Don't delink hardlinks
      version-control t      ; Use version numbers on backups
      delete-old-versions t  ; Automatically delete excess backups
      kept-new-versions 20   ; how many of the newest versions to keep
      kept-old-versions 5    ; and how many of the old

      create-lockfiles nil   ; no lock file
      )

(setq-default  tab-width 2
               standard-indent 2
               indent-tabs-mode nil)	; makes sure tabs are not used.

(global-auto-revert-mode 1)

;; Bookmarks
(require 'bookmark)
(setq bookmark-default-file (expand-file-name "bookmarks" cache-dir)
      bookmark-save-flag 1)

;; Smex
(require-package 'smex)
(setq smex-save-file (expand-file-name ".smex-items" cache-dir))
(smex-initialize)
(bind-key "M-x" 'smex)
(bind-key "<menu>" 'smex)
(setq smex-history-length 100)

;; Pojectile
(require-packages '(projectile ag))
(setq projectile-cache-file (expand-file-name  "projectile.cache" cache-dir)
      projectile-known-projects-file (expand-file-name  "projectile-bookmarks.eld" cache-dir)
      ag-highlight-search t)
(projectile-global-mode)

(bind-key "s-a" 'ag-project)
(bind-key "s-A" 'ag)
(bind-key "s-d" 'projectile-find-dir)
(bind-key "s-D" 'projectile-dired)
(bind-key "s-f" 'projectile-find-file)
(bind-key "s-F" 'ido-find-file)
(bind-key "s-C-f" 'projectile-find-file-in-directory)
(bind-key "s-t" 'projectile-find-test-file)
(bind-key "s-g" 'projectile-grep)
(bind-key "s-T" 'projectile-regenerate-tags)
(bind-key "s-R" 'projectile-replace)
(bind-key "s-p" 'projectile-switch-project)

(bind-key "s-b" 'ido-switch-buffer)
(bind-key "s-B" 'projectile-recentf)
(bind-key "s-k" 'projectile-kill-buffers)
(bind-key "s-r" 'recentf-ido-find-file)

;; Smartparens
(require-package 'smartparens)
(require 'smartparens-config)
(smartparens-global-mode t)
(show-paren-mode)
;; (show-smartparens-global-mode t)
(setq sp-autoescape-string-quote nil)
;; https://github.com/Fuco1/smartparens/wiki/Example-configuration

;;; html-mode
(sp-with-modes '(html-mode sgml-mode)
  (sp-local-pair "<" ">"))

;; Rainbow Mode
(require-package 'rainbow-mode)
(eval-after-load 'css-mode
  '(progn
     (defun css-mode-defaults ()
       (rainbow-mode +1))

     (add-hook 'css-mode-hook (run-hooks 'css-mode-hook))))

;; Recentf
(require-package 'recentf)
(setq recentf-max-saved-items 500
      recentf-max-menu-items 15
      recentf-exclude '(
                        "\.hist$" "/COMMIT_EDITMSG$" "/tmp/" "/ssh:" "/sudo:"
                        ))
(recentf-mode +1)

;; Flyspell
(require 'flyspell)
(setq ispell-program-name "aspell" ; use aspell instead of ispell
      ispell-extra-args '("--sug-mode=ultra"))
(flyspell-mode +1)

;; Dired
(setq dired-recursive-deletes 'always)
(setq dired-recursive-copies 'always)
(setq dired-dwim-target t)
(bind-key "C-c j" 'dired-jump)

;; Undo Tree
(require-package 'undo-tree)
(setq undo-tree-visualizer-timestamps t
      undo-tree-history-directory-alist (quote (("." . "~/.cache/emacs/undo-tree")))
      undo-tree-auto-save-history t
      undo-tree-visualizer-relative-timestamps nil
      undo-tree-visualizer-diff t
      undo-limit 600000
      undo-strong-limit 900000)
(global-undo-tree-mode)
(defadvice undo-tree-make-history-save-file-name
  (after undo-tree activate)
  (setq ad-return-value (concat ad-return-value ".gz")))

;; Align
(bind-key "C-x \\" 'align-regexp)

;; Font size
(bind-key "C-+" 'text-scale-increase)
(bind-key "C--" 'text-scale-decrease)

;; Proced
(bind-key "C-x p" 'proced)

;; expand-region
(require-package 'expand-region)
(bind-key "C-=" 'er/expand-region)

;; Wrap Region
(require-package 'wrap-region)
(wrap-region-global-mode)
(require-package 'change-inner)
(bind-key "<f4>i" 'change-inner)
(bind-key "<f4>o" 'change-outer)
(bind-key "<f4><f4>i" 'copy-inner)
(bind-key "<f4><f4>o" 'copy-outer)

;; Ace Jump
(require-package 'ace-jump-mode)

;; Comment
(bind-key "M-;" 'comment-dwim-line)

;; key-chord
(require-package 'key-chord)
(setq key-chord-two-keys-delay 0.2)

(key-chord-define-global "uu" 'undo-tree-visualize)
(key-chord-define-global "  " 'ace-jump-word-mode)
;; (key-chord-define-global "yy" 'copy-current-line)
(key-chord-define-global ";w" 'save-buffer)
(key-chord-define-global "vv" 'select-current-line)
(key-chord-define-global "JJ" 'mode-line-other-buffer) ; Switch to previous buffer

(bind-key "M-j" 'indent-new-comment-line)
(bind-key "C-j" 'newline)
(bind-key "RET" 'newline-and-indent)
(bind-key "<C-return>" 'newline)
(electric-indent-mode -1)
;; (add-hook 'after-save-hook (lambda () (interactive) (indent-region (line-beginning-position) (line-end-position))))

(require-package 'ace-jump-buffer)
;; (key-chord-define-global "bb" 'ace-jump-buffer)

(key-chord-mode +1)

;; Ack
(require-package 'ack-and-a-half)
(defalias 'ack 'ack-and-a-half)

;; Multiple Cursors
(require-package 'multiple-cursors)
(bind-key "<f5>a" 'mc/edit-beginnings-of-lines)
(bind-key "<f5>e" 'mc/edit-ends-of-lines)
(bind-key "<f5><f5>e" 'mc/edit-lines)
(bind-key "<f5><down>" 'mc/mark-next-like-this)
(bind-key "<f5><up>" 'mc/mark-previous-like-this)
(bind-key "<f5><left>" 'mc/unmark-next-like-this)
(bind-key "<f5><right>" 'mc/unmark-previous-like-this)
(bind-key "<f5>m" 'mc/mark-more-like-this-extended)
(bind-key "<f5><f5>a" 'mc/mark-all-dwim)
(bind-key "<s-mouse-1>" 'mc/add-cursor-on-click)
(bind-key "<f5>r" 'mc/reverse-regions)
(bind-key "<f5>s" 'mc/sort-regions)
(bind-key "<f5>i" 'mc/insert-numbers)
(bind-key "<f5>l" 'set-rectangular-region-anchor)

;; White Space
(setq whitespace-line-column 100)

;; SQL Mode
(add-hook 'sql-interactive-mode-hook (lambda ()
                                       (yas-minor-mode -1)))

;; Gnutls
(setq gnutls-min-prime-bits 2048)

;; Doc View
(setq doc-view-continuous t)
(add-hook 'doc-view-mode-hook (lambda ()
                                (bind-key "j" 'doc-view-next-line-or-next-page doc-view-mode-hook)
                                (bind-key "k" 'doc-view-previous-line-or-previous-page doc-view-mode-hook)
                                (bind-key "h" 'image-backward-hscroll doc-view-mode-map)
                                (bind-key "l" 'image-forward-hscroll doc-view-mode-map)
                                ))

(setq mouse-drag-copy-region nil)  ; stops selection with a mouse being immediately injected to the kill ring
(setq x-select-enable-primary t)  ; stops killing/yanking interacting with primary X11 selection
(setq x-select-enable-clipboard t)  ; makes killing/yanking interact with clipboard X11 selection
(setq interprogram-paste-function 'x-cut-buffer-or-selection-value)
(setq mouse-yank-at-point t)
(bind-key "<mouse-2>" 'mouse-yank-at-click)
(bind-key "<S-mouse-2>" 'mouse-yank-at-click)

;; overwrite region if any active
(delete-selection-mode 1)

;; browse-kill-ring
(require-package 'browse-kill-ring)
;; (require-package 'popup-kill-ring)
(setq browse-kill-ring-highlight-current-entry t
      browse-kill-ring-display-duplicates nil)

(browse-kill-ring-default-keybindings)
(bind-key "C-n"      'browse-kill-ring-forward browse-kill-ring-mode-map)
(bind-key "C-p"      'browse-kill-ring-previous browse-kill-ring-mode-map)
(bind-key "C-g"      'browse-kill-ring-quit browse-kill-ring-mode-map)
(bind-key "<escape>" 'browse-kill-ring-quit browse-kill-ring-mode-map)
(bind-key "C-x y"    'browse-kill-ring)

;; Pomodoro
(require-package 'pomodoro)
(setq pomodoro-sound-player "/usr/bin/mplayer"
      pomodoro-break-start-sound "/usr/share/sounds/purple/alert.wav"
      pomodoro-work-start-sound "/usr/share/sounds/freedesktop/stereo/message-new-instant.oga"
      )
(add-hook 'after-init-hook 'pomodoro-add-to-mode-line)
(pomodoro-start nil)

;; Helm
(require-packages '(helm-descbinds helm-go-package helm-projectile))
(defun my-helm()
  (interactive)
  (require 'helm-eval)
  (require 'helm-files)
  (setq sources nil)
  (if (projectile-project-p)
      (setq sources '(helm-source-projectile-buffers-list
                      helm-source-projectile-files-list)))
  (setq sources (append sources '(helm-source-buffers-list
                                  helm-source-ido-virtual-buffers
                                  helm-source-files-in-current-dir
                                  helm-source-bookmarks
                                  helm-source-etags-select
                                  helm-source-recentf
                                  helm-source-calculation-result)
                        ))
  (helm-other-buffer sources "*my helm*"))
(bind-key "s-h" 'my-helm)


;; Google Translation
(require-package 'google-translate)

(setq google-translate-default-source-language "auto"
      google-translate-default-target-language "zh-CN"
      google-translate-show-phonetic t)
(bind-key "<f1>t" 'google-translate-query-or-region)

;; Drag Stuff
(require-package 'drag-stuff)
(drag-stuff-global-mode)

;; wgrep
(require-package 'wgrep)

;; s.el
(require-package 's)
(bind-key "<f4>-" `(lambda () (interactive) (replace-region-by 's-dashed-words)))
(bind-key "<f4>_" `(lambda () (interactive) (replace-region-by 's-snake-case)))
(bind-key "<f4>SPC" `(lambda () (interactive) (replace-region-by (lambda (word) (s-replace "-" " " (s-dashed-words word))))))
(bind-key "<f4>c" `(lambda () (interactive) (replace-region-by 's-lower-camel-case)))
(bind-key "<f4>C" `(lambda () (interactive) (replace-region-by 's-upper-camel-case)))
(bind-key "<f4>t" `(lambda () (interactive) (replace-region-by 's-titleize)))
(bind-key "<f4>d" `(lambda () (interactive) (replace-region-by 's-downcase)))

;; Zeal At Point
(require-package 'zeal-at-point)
(bind-key "<M-f6>" 'zeal-at-point)
