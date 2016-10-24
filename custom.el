(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("88ae008e9bf586a903dfb4e7ca6d9c06f6b1f8ce10d2ae89295a4114a6f2c3f3" "9527feeeec43970b1d725bdc04e97eb2b03b15be982ac50089ad223d3c6f2920" default)))
 '(flycheck-display-errors-function (function flycheck-pos-tip-error-messages))
 '(ido-use-filename-at-point nil)
 '(package-selected-packages
   (quote
    (material-theme protobuf-mode auctex tide all-the-icons doom-themes elixir-yasnippets Yasnippet go-complete go-mode go js-doc slime jade wgrep-ag wgrep wgrep-ack ruby-end ag youdao-dictionary multiple-cursor ace-window corral web-mode org-bullets edts erlang-mode alchemist elixir-mode auto-complete js2-refactor debbugs js2-mode yesql-ghosts yasnippet whitespace-cleanup-mode visual-regexp string-edit smartparens simple-httpd restclient prodigy paredit nodejs-repl move-text markdown-mode magit inflections ido-vertical-mode ido-at-point hydra htmlize highlight-escape-sequences guide-key groovy-mode gist flycheck-pos-tip flycheck-clojure flx-ido fill-column-indicator exec-path-from-shell elisp-slime-nav edn dockerfile-mode dired-details css-eldoc clojure-mode-extra-font-locking)))
 '(safe-local-variable-values
   (quote
    ((eval font-lock-add-keywords nil
           (quote
            (("defexamples\\|def-example-group\\| => "
              (0
               (quote font-lock-keyword-face)))
             ("(defexamples[[:blank:]]+\\(.*\\)"
              (1
               (quote font-lock-function-name-face))))))
     (eval font-lock-add-keywords nil
           (quote
            (("defexamples\\|def-example-group\\| => "
              (0
               (quote font-lock-keyword-face))))))
     (eval when
           (and
            (buffer-file-name)
            (file-regular-p
             (buffer-file-name))
            (string-match-p "^[^.]"
                            (buffer-file-name)))
           (emacs-lisp-mode))
     (eval font-lock-add-keywords nil
           (quote
            (("defexamples\\| => "
              (0
               (quote font-lock-keyword-face))))))
     (encoding . utf-8)))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js2-error-face ((t nil)) t)
 '(js2-warning-face ((t nil)) t))
(add-to-list 'auto-mode-alist '("\\.jsx?\\'" . web-mode))
;;configuration for web-mode
(setq web-mode-content-types-alist
      '(("jsx"  . "\\.jsx?\\'")))
(setq web-mode-code-indent-offset 2)
;;font config
(add-to-list 'initial-frame-alist '(font . "Inconsolata-14" ))
(add-to-list 'default-frame-alist '(font . "Inconsolata-14" ))
;; (set-face-attribute 'default t :font "Inconsolata-12" )
;; set up org mode bullets
(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(setq auto-save-default nil)
;; set ace-window select keys
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
;; corral
(setq corral-preserve-point t)
;; youdao
(setq url-automatic-caching t)
(global-set-key (kbd "C-c y") 'youdao-dictionary-search-at-point)

;;elixir
;;(eval-after-load 'alchemist-mode '(require 'elixir-mode))

(require 'ag)
;; (require 'wgrep)
;; (autoload 'wgrep-ag-setup "wgrep-ag")
;; (add-hook 'ag-mode-hook 'wgrep-ag-setup)
(require 'elixir-mode)
(require 'alchemist)
(add-hook 'alchemist-mode-hook 'company-mode)
(add-to-list 'elixir-mode-hook
             (defun auto-activate-ruby-end-mode-for-elixir-mode ()
               (set (make-variable-buffer-local 'ruby-end-expand-keywords-before-re)
                    "\\(?:^\\|\\s-+\\)\\(?:do\\)")
               (set (make-variable-buffer-local 'ruby-end-check-statement-modifiers) nil)
               (ruby-end-mode +1)))
;;for golang
(require 'go-mode-autoloads)
(add-hook 'web-mode-hook 'electric-pair-local-mode)
;; jade
;;(add-hook 'js2-mode-hook #'jade-interaction-mode)

;; active Babel languages
;; (require 'ob-clojure)
;; (setq org-babel-clojure-backend 'cider)
;; (org-babel-do-load-languages
;;  'org-babel-load-languages
;;  '((R . t)
;;    (emacs-lisp . t)
;;    (clojure . t)
;;    ))

;; js-doc
(require 'js-doc)

;;doom themes
;; (load-theme 'doom-one t) ;; or doom-dark, etc.

;;; OPTIONAL
;; brighter source buffers
;; (add-hook 'find-file-hook 'doom-buffer-mode)
;; brighter minibuffer when active
;; (add-hook 'minibuffer-setup-hook 'doom-buffer-mode)

;;Typescript for angular

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

;; format options
(setq tide-format-options '(:insertSpaceAfterFunctionKeywordForAnonymousFunctions t :placeOpenBraceOnNewLineForFunctions nil))

;; protobuf
(require 'protobuf-mode)
(defconst my-protobuf-style
  '((c-basic-offset . 2)
    (indent-tabs-mode . nil)))

(add-hook 'protobuf-mode-hook
          (lambda () (c-add-style "my-style" my-protobuf-style t)))

;; AUCTeX
(load "auctex.el" nil t t)
;; dired-x
(require 'dired-x)
(load-theme 'material t)
