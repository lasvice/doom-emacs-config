;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "fantasque sans mono" :size 16 :weight 'regular)
;;       doom-variable-pitch-font (font-spec :family "ETBembo" :size 17))

(setq doom-font (font-spec :family "fira code" :size 30 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "fira code" :size 30))
      ;; doom-variable-pitch-font (font-spec :family "ETBembo" :size 17))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;; evil

(use-package! evil-escape
  :init
  (setq evil-escape-unordered-key-sequence t)) ; enable "k j"

(map! :desc "Switch to next window"
      :nvi "s-j" 'evil-window-next)

(map! :desc "Switch to previous window"
      :nvi "s-k" 'evil-window-prev)

;;; general

(map! :desc "Expand region"
      :nvi "C-=" 'er/expand-region)

(map! :desc "Shrink region"
      :nvi "C--" 'er/contract-region)

(map! :desc "Move to the begining of a line in all modes"
      :nvi "C-a" 'doom/backward-to-bol-or-indent)

(map! :desc "Move to the end of a line in all modes"
      :nvi "C-e" 'doom/forward-to-last-non-comment-or-eol)

;;; Editing

(map! :desc "Substitute"
      :v "s" 'evil-substitute)

(map! :desc "kill-line"
      :nvi "C-k" 'kill-line)

;;; paredit

(after! clojure-mode
  (enable-paredit-mode))

(after! clojurescript-mode
  (enable-paredit-mode))

(map! :map paredit-mode-map
      :desc "Splice secp kill backward"
      :nvi "<prior>" 'paredit-splice-sexp-killing-backward)

(map! :desc "Splice secp kill forward"
      :map paredit-mode-map
      :nvi "<next>" 'paredit-splice-sexp-killing-forward)

(map! :desc "Structurally kill line"
      :map paredit-mode-map
      :nvi "C-k" 'paredit-kill)

(map! :desc "Forward delete"
      :map paredit-mode-map
      :i "C-d" 'paredit-forward-delete)

(map! :desc "Forward kill word"
      :map paredit-mode-map
      :i "M-d" 'paredit-forward-kill-word)

(map! :desc "Backward delete"
      :map paredit-mode-map
      :i "<backspace>" 'paredit-backward-delete)

(map! :desc "Backward kill word"
      :map paredit-mode-map
      :i "M-<backspace>" 'paredit-backward-kill-word)

;;; cider

(use-package! cider
  :init
  (setq clojure-toplevel-inside-comment-form nil))

(map! :map cider-mode-map
      :desc "Eval last sexp"
      :nvi "M-<return>" 'cider-eval-last-sexp)

(map! :map cider-mode-map
      :desc "Eval last sexp and output into a buffer"
      :nvi "M-S-<return>" 'cider-pprint-eval-last-sexp)

(map! :map cider-mode-map
      :desc "Eval toplevel"
      :nvi "C-<return>" 'cider-eval-defun-at-point)

(map! :map cider-mode-map
      :desc "Eval toplevel and output into a buffer"
      :nvi "C-S-<return>" 'cider-pprint-eval-defun-at-point)

(map! :map cider-mode-map
      :desc "Eval sexp up to the point"
      :nvi "C-M-<return>" 'cider-eval-sexp-up-to-point)

(map! :map cider-mode-map
      :desc "Eval sexp up to the point and output into a buffer"
      :nvi "C-M-S-<return>" 'cider-pprint-eval-sexp-up-to-point)

(defun cider-pprint-eval-sexp-up-to-point ()
  (interactive)
  (cider-eval-sexp-up-to-point 't))

;;; tab

(map! :map centaur-tabs-mode-map
      :desc "tab shortcuts"
      :nvi "C-<tab>" 'centaur-tabs-forward)

(map! :map centaur-tabs-mode-map
      :desc "tab shortcuts"
      :nvi "s-h" 'centaur-tabs-backward)

(map! :map centaur-tabs-mode-map
      :desc "tab shortcuts"
      :nvi "s-l" 'centaur-tabs-forward)

;;; Promela mode

(use-package! promela-mode
  :mode ("\\.pml\\'" . promela-mode)
  :custom
  (promela-block-indent 2)
  (promela-auto-match-delimiter nil))

;;; Alloy mode

(use-package! alloy-mode
  :mode ("\\.als\\'" . alloy-mode))
