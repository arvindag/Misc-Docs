(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Monaco" :foundry "unknown" :slant normal :weight normal :height 113 :width normal)))))

(add-to-list 'default-frame-alist '(left . 0))
(add-to-list 'default-frame-alist '(top . 0))
(add-to-list 'default-frame-alist '(height . 65))
(add-to-list 'default-frame-alist '(width . 180))

(setq frame-title-format '(buffer-file-name "%f"(dired-directory dired-directory "%b")))

(global-set-key   [f2]     'set-mark-command)            ; F2
(global-set-key   [f3]     'copy-to-register)            ; F3
(global-set-key   [f4]     'insert-register)             ; F4
(global-set-key   [f5]     'call-last-kbd-macro)         ; F5
(global-set-key   [f6]     'other-window)                ; F6
(global-set-key   [f7]     'delete-other-windows)        ; F7
(global-set-key   [f8]     'split-window-vertically)     ; F8
(global-set-key   [f9]     'split-window-horizontally)   ; F9
(global-set-key   [f10]    'list-buffers)                ; F10

;; For Ubuntu
(global-set-key   [f11] `goto-line)                   ; F11
(global-set-key   [f12] `save-buffer)                 ; F12

(global-set-key   [kp-begin]    'kill-buffer)                 ; 5 (Numeric Pad)

(global-set-key   "\C-r"   'query-replace)               ; C-r
(global-set-key   "\C-u"   'undo)                        ; C-u
(global-set-key   [delete] 'delete-char)                 ; DEL

(global-set-key   "\e\e"   'eval-expression)             ; ESC-ESC

(global-set-key   "\C-z"   'bury-buffer)                 ; C-z
(global-set-key   "\C-x\C-b" 'buffer-menu-other-window)  ; C-x C-b

(setq default-tab-width 4)
(setq-default c-basic-offset 4)
(setq-default cperl-indent-level 4)
(setq-default js-indent-level 2)
(setq-default tab-width 4)

(setq-default indent-tabs-mode nil)

; Set the c++ mode for .h files by default
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

