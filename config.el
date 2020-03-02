;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!


;; These are used for a number of things, particularly for GPG configuration,
;; some email clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;;(setq doom-font (font-spec :family "monospace" :size 14))
(setq doom-font (font-spec :family "monospace" :size (if (> (x-display-pixel-width )1920 )24 14)))
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
(setq doom-theme 'doom-one)

;; If you intend to use org, it is recommended you change this!
(setq org-directory "~/org/")

;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', where Emacs
;;   looks when you load packages with `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.



;;rime 词库
(use-package! liberime-config
 :init
 (add-hook 'liberime-after-start-hook
            (lambda ()
              (liberime-select-schema "luna_pinyin_simp")))
  )

;;pyim
(use-package! pyim
  :after liberime-config
  :config
  (setq default-input-method "pyim")
  (setq pyim-default-scheme 'rime)
  (setq pyim-page-length 9)
  (setq pyim-page-tooltip 'posframe)
)

;;org-protocol
(add-to-list 'org-modules 'org-protocol t)
(use-package! org-protocol
  :config
  (add-to-list 'org-capture-templates
               '("w" "org-protocol" entry (file "~/projects/org/refile.org")
                 "* TODO Review %a\n%U\n%:initial\n" :immediate-finish t))
  (setq org-protocol-default-template-key "w")
  )

;;EAF
(use-package eaf
  :load-path "~/projects/github/emacs-application-framework"
  :custom
  (eaf-find-alternate-file-in-dired t)
  :config
  (eaf-bind-key scroll_up "RET" eaf-pdf-viewer-keybinding)
  (eaf-bind-key scroll_down_page "DEL" eaf-pdf-viewer-keybinding)
  (eaf-bind-key scroll_up "C-n" eaf-pdf-viewer-keybinding)
  (eaf-bind-key scroll_down "C-p" eaf-pdf-viewer-keybinding)
  (eaf-bind-key take_photo "p" eaf-camera-keybinding))
  (add-to-list 'evil-emacs-state-modes 'eaf-mode)


;;EAF proxy
(setq eaf-proxy-type "http")
(setq eaf-proxy-host "127.0.0.1")
(setq eaf-proxy-port "1092")
(setq eaf-proxy-type "socks5")

;;awesome-tab
(use-package awesome-tab
  :load-path "~/projects/github/awesome-tab"
  :config
  (awesome-tab-mode t)
  )

;;keybinds
(map! :map awesome-tab-mode
      :leader
      :n "[ j" #'awesome-tab-forward
      :n "[ k" #'awesome-tab-backward
      :n "[ a" #'awesome-tab-select-beg-tab
      :n "[ e" #'awesome-tab-select-end-tab)

;;tools magit
(setq magit-repository-directories '(("~/projects" . 2))
      magit-save-repository-buffers nil
      ;; Don't restore the wconf after quitting magit
      magit-inhibit-save-previous-winconf t
      transient-values '((magit-commit "--gpg-sign=F3EA7A994411B2B9")
                         (magit-rebase "--autosquash" "--gpg-sign=F3EA7A994411B2B9")
                         (magit-pull "--rebase" "--gpg-sign=F3EA7A994411B2B9"))
      )



;;snails
(use-package! snails
  :demand
  :config
  (add-to-list 'evil-emacs-state-modes 'snails-mode)
  )

;;org-babel
(org-babel-do-load-languages
 'org-babel-load-languages
 '((sql . t)))

;;paredit.el
(load! "lisp/paredit.el")
