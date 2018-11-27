;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)



;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(custom-safe-themes
;;    (quote
;; 	("8ed752276957903a270c797c4ab52931199806ccd9f0c3bb77f6f4b9e71b9272" default)))
;;  '(package-selected-packages
;;    (quote
;; 	(auto-complete monokai-theme ## forecast rainbow-delimiters ace-window))))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )


;; 튜토리얼 메시지 없애기
(setq inhibit-startup-message t)


;; 커서 라인 표시하기
(global-hl-line-mode 1)


;; 화면 왼쪽에 라인넘버 표시
(global-linum-mode t)

;; 선택 영역 표시
(transient-mark-mode t)

;; dired mode go back 뒤로가기
(global-set-key (kbd "C-,") 'dired-up-directory)

;; projectile
;; (projectile-mode)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
;; (require 'projectile)
;; (projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
;; (require 'helm-projectile)
;; ;; (require 'helm-config)
;; (global-set-key (kbd "C-x p") 'helm-projectile)

(setq projectile-project-search-path '("~/Project/OAF"))
(add-to-list 'package-pinned-packages '(projectile . "melpa-stable") t)


;; Custom Modules Path
(add-to-list 'load-path "~/.emacs.d/custom/")

;; Custom Modules Path
(require 'setup-theme)
;; (require 'setup-editting)
;; (require 'setup-query)
;; (require 'setup-etc)
;; (require 'setup-external)
;; (require 'utils-helm)


	 ;==============================================================================
	 ;; TAB KEY
	 ;==============================================================================

	 ;; 탭 사이즈 : 2
	 (setq-default tab-width 2)

	 ;; 탭키를 일반 에디터에서 작동하는 방식으로 변경
	 (global-set-key (kbd "TAB") 'self-insert-command)

	 ;; =======================================================
	 ;; window function
	 ;; =======================================================

	 ;; M-x 대용
	 (global-set-key (kbd "<f8>") 'execute-extended-command)

	 ;; goto-line
	 ;; (define-key global-map (kbd "C-l") 'goto-line)

	 ;; 현재 창 닫기
	 (define-key global-map (kbd "C-<f4>") 'kill-this-buffer)

	 ;; 현재 창만 남기고 다른 창 모두 닫기
	 (define-key global-map (kbd "<f4>") 'delete-other-windows)


	 ;; 상태표시줄에 가로 세로 위치 표시
	 (column-number-mode t)
	 ;; (add-hook 'find-file-hook (lambda () (linum-mode t)))
	 (line-number-mode t)

;; yes/no 입력 대신 y/n 입력하도록 변경
(fset 'yes-or-no-p 'y-or-n-p)

;; remove all trailing space when you save
(add-hook 'write-file-hooks
  'delete-trailing-whitespace)

;; 띵띵소리 없애기
(setq ring-bell-function 'ignore)

;; 윈도우 제목 설정
(setq frame-title-format "Emacs - %b")
(setq icon-title-format "Emacs - %b")
;; (setq frame-title-format
;;   '(buffer-file-name
;;     "Emacs - [%f]"
;;     (dired-directory dired-directory "Emacs - [%b]")))

;; 미니버퍼 히스토리를 저장한다.
(savehist-mode 1)

;; 기본 모드 : text-mode
(setq initial-major-mode 'text-mode)

;==============================================================================
;; shell
;==============================================================================
;; (require 'shell-command) (shell-command-completion-mode)
(add-hook 'shell-mode-hook 'n-shell-mode-hook)
(defun n-shell-mode-hook ()
  "12Jan2002 - sailor, shell mode customizations."
  (local-set-key '[up] 'comint-previous-input)
  (local-set-key '[down] 'comint-next-input)
  (setq comint-input-sender 'n-shell-simple-send))

(defun n-shell-simple-send (proc command)
  "17Jan02 - sailor. Various commands pre-processing before sending to shell."
  (cond
   ((string-match "^[ \t]*clear[ \t]*$" command)
     (comint-send-string proc "\n")
     (erase-buffer))
   ((string-match "^[ \t]*c[ \t]*$" command)
     (comint-send-string proc "\n")
     (erase-buffer))
   ;; Send other commands to the default handler.
   (t (comint-simple-send proc command))))

;; =============================================================================
;; 상태표시줄(status bar)에 디렉토리를 포함한 파일명 표시
;; =============================================================================

(setq-default mode-line-buffer-identification
              (list 'buffer-file-name
                    (propertized-buffer-identification "%12f")
                    (propertized-buffer-identification "%12b")))

;; (add-hook 'dired-mode-hook
;;           (lambda ()
;;             ;; TODO: handle (DIRECTORY FILE ...) list value for dired	-directory
;;             (setq mode-line-buffer-identification
;;                   ;; emulate "%17b" (see dired-mode):
;;                   '(:eval
;;                     (propertized-buffer-identification
;;                      (if (< (length default-directory) 17)
;;                          (concat default-directory
;;                                  (make-string (- 17 (length default-directory))
;;                                               ?\s))
;;                        default-directory))))))



;;==============================================================================
;; 최근 열었던 파일 가져오기
;;==============================================================================

(recentf-mode 1)
(setq recentf-max-saved-items 1200)

;; 제외할 파일
(add-to-list 'recentf-exclude "Temporary Internet Files")

;; 자동 저장기능 활성화
;;(setq recentf-auto-save-timer
;;  (run-with-idle-timer 30 t 'recentf-save-list))

(global-set-key [f12] 'recentf-open-files)


;; 탭키를 이용하여 최근 파일명 완성하기
(defun recentf-open-files-compl ()
  (interactive)
  (let* ((all-files recentf-list)
      (tocpl (mapcar (function
          (lambda (x) (cons (file-name-nondirectory x) x))) all-files))
      (prompt (append '("File name: ") tocpl))
    (fname (completing-read (car prompt) (cdr prompt) nil nil)))
    (find-file (cdr (assoc-string fname tocpl nil)))))

(global-set-key "\C-c\C-r" 'recentf-open-files-compl)


;; 기본언어를 한글로 지정
(set-language-environment "Korean")

;; 기본 파일 인코딩 설정
;(prefer-coding-system 'korean-cp949-dos)
(prefer-coding-system 'utf-8)


;; 양끝 괄호 표시
;; show	paren mode
(show-paren-mode 1)
(setq show-paren-delayi 0)

;;show time on status bar
(display-time)


;==============================================================================
;; Auto Save & Backup File
;==============================================================================

(setq make-backup-files t)
(setq auto-save-default t)

(setq
  make-backup-files t
  backup-by-copying t
  delete-old-versions t
  kept-new-versions 10
  kept-old-versions 10
  version-control t)      ;; Make numbered backups

;; create the autosave dir if necessary, since emacs won't.
(make-directory "~/.autosave.d/" t)

;; 디렉토리 설정
(setq
  backup-directory-alist `((".*" . ,"~/.autosave.d/"))
  auto-save-file-name-transforms `((".*" ,"~/.autosave.d/" t))
  tramp-auto-save-directory "~/.autosave.d/")

;; ftp 파일에 대해 백업파일 설정
(setq ange-ftp-auto-save 1)           ;; only 0 or 1 (DO NOT USE t or nil !!!)
(setq ange-ftp-make-backup-files t)

;; auto-save every 100 input events
(setq auto-save-interval 100)

;; auto-save after 30 seconds idle time
(setq auto-save-timeout 30)


;; C-u C-SPC 이후 C-SPC 연타를 허용한다.
(setq set-mark-command-repeat-pop  t)


;; (setq calendar-latitude 37.551301
;; 	  calendar-longitude 126.988232
;;       forecast-city "Seoul"
;;       forecast-country "South Korea")

;; (setq clendar-latitude 37.551301
;; 	  calendar-longitude 126.988232
;;       calendar-location-name "Seoul Korea"
;;       forecast-city "Korea")

;; (load (locate-user-emacs-file "forecast-api-key.el"))

;; =============================================================================
;; 패키지 시스템(MELPA)
;; =============================================================================

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
  (package-initialize))

(gnutls-available-p)
;;=> t

;; (load (locate-user-emacs-file "forecast-api-key.el"))
;(load (load-tls "tls.el"))


;; =============================================================================
;; search
;; ==================
;; search option
(setq-default case-replace nil) ; 바꿀 때 결코 대소문자를 바꾸지 말것


;; =============================================================================
;; Theme
;; =============================================================================
;; (load-theme 'zenburn t)
;;(load-theme 'moe-dar)
;;(load-theme 'moe-dark t)
;; (load-theme 'monokai t)

(set-face-attribute 'region nil :background "#666" :foreground "#ffffff")
;; (set-face-attribute 'region nil :background "#ffEB3B" :foreground "#ffffff")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; undo tree mode                                                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; C-x u : show undo tree

;; ;;turn on everywhere
;; (global-undo-tree-mode 1)
;; ;; make ctrl-z undo
;; (global-set-key (kbd "C-z") 'undo)
;; ;; make ctrl-Z redo
;; (defalias 'redo 'undo-tree-redo)
;; (global-set-key (kbd "C-'") 'redo)





;; 하나의 버퍼에서 A 위치에서 작업하다가 B 위치로 잠시 이동 후 다시 A 위치로 돌아오려 할 때
;; C-SPC C-SPC(영역이 선택된 상태면 C-SPC 한번이면 됩니다.) 입력 후
;; 다른곳에서 작업한 이후에
;; C-u C-SPC 를 입력하면 마크를 지정한 위치로 돌아올 수 있다.
;; 이맥스는 여러 명령에서 자동으로 마크를 지정한다.
;; 그럴 경우 C-u C-SPC 를 여러번 입력해야 한다.
;; 아래 내용을 설정파일에 추가해주면 편리하다.

;; C-u C-SPC 이후 C-SPC 연타를 허용한다.
(setq set-mark-command-repeat-pop  t)






;; ============================================================================
;; 대응하는 괄호 자동입력
;; ============================================================================
;; (when (>= emacs-major-version 24)
;;   (electric-pair-mode 1))








;; =============================================================================
;; 커서 위치 대소문자 변환
;; =============================================================================

;; 영역이 선택되어 있으면 영역을 대문자 또는 소문자로 변환하고, 영역이 없으면 커서가 있는 문자를 대문자 또는 소문자로 변환.


(defun my-upcase-char-or-region ()
  "change char or selected region to upper case."
  (interactive)
  (if (not mark-active)
      (upcase-region (point) (+ (point) 1))
    (upcase-region (region-beginning) (region-end))
    (setq deactivate-mark nil)))

(defun my-downcase-char-or-region ()
  "change char or selected region to lower case."
  (interactive)
  (if (not mark-active)
      (downcase-region (point) (+ (point) 1))
    (downcase-region (region-beginning) (region-end))
    (setq deactivate-mark nil)))

(global-set-key (kbd "<f5>") 'my-upcase-char-or-region)
(global-set-key (kbd "C-<f5>") 'my-downcase-char-or-region)

;; =============================================================================
;; 데스크탑 모드
;; =============================================================================

;; 이맥스 재실행시 열려있던 파일 복구
(desktop-save-mode 1)

;; t             -- always save.
;; ask           -- always ask.
;; ask-if-new    -- ask if no desktop file exists, otherwise just save.
;; ask-if-exists -- ask if desktop file exists, otherwise don’t save.
;; if-exists     -- save if desktop file exists, otherwise don’t save.
;; nil           -- never save.
(setq desktop-save t)
;; (setq desktop-save 'ask-if-new)

(put 'narrow-to-region 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(global-mark-ring-max 5000)
 '(multi-term-dedicated-close-back-to-open-buffer-p t)
 '(multi-term-dedicated-select-after-open-p t)
 '(multi-term-dedicated-skip-other-window-p t)
 '(package-selected-packages
	 (quote
		(helm-descbinds projectile helm multi-term zenburn-theme use-package switch-window monokai-theme ggtags counsel-gtags auto-complete async)))
 '(term-bind-key-alist
	 (quote
		(("M-]" . multi-term-next)
		 ("M-[" . multi-term-prev)
		 ("C-c C-c" . term-interrupt-subjob)
		 ("C-c C-e" . term-send-esc)
		 ("C-p" . previous-line)
		 ("C-n" . next-line)
		 ("C-s" . isearch-forward)
		 ("C-r" . isearch-backward)
		 ("C-m" . term-send-return)
		 ("C-y" . term-paste)
		 ("M-f" . term-send-forward-word)
		 ("M-b" . term-send-backward-word)
		 ("M-o" . term-send-backspace)
		 ("M-p" . term-send-up)
		 ("M-n" . term-send-down)
		 ("M-M" . term-send-forward-kill-word)
		 ("M-N" . term-send-backward-kill-word)
		 ("<C-backspace>" . term-send-backward-kill-word)
		 ("M-r" . term-send-reverse-search-history)
		 ("M-d" . term-send-delete-word)
		 ("M-," . term-send-raw)
		 ("M-." . comint-dynamic-complete)
		 ("C-a" . move-beginning-of-line)))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(put 'erase-buffer 'disabled nil)



;; ============================================================================
;; multi-term is an available obsolete package.
;; ============================================================================

(require 'multi-term)
(setq multi-term-program "/bin/bash")

;; (add-hook 'term-mode-hook
;;           (lambda ()
;;             (add-to-list 'term-bind-key-alist '("M-[" . multi-term-prev))
;;             (add-to-list 'term-bind-key-alist '("M-]" . multi-term-next)))
;; )

(global-set-key (kbd "C-t") 'multi-term)

(define-key term-mode-map (kbd "C-j") 'term-char-mode)
(define-key term-raw-map (kbd "C-j") 'term-line-mode)

;; (add-to-list 'load-path "~/.emacs.d/multi-term-plus")
;; (require 'multi-term-config)

;; (global-set-key (kbd "C-t") 'get-term)
;; (require 'bash-completion)
;; (bash-completion-setup)



;; ============================================================================
;; helm config
;; ============================================================================
(require 'helm-config)
(setq helm-idle-delay 0.1)
(setq helm-input-idle-delay 0.1)

(global-set-key (kbd "M-t") 'helm-for-files)

(require 'helm-descbinds)
(helm-descbinds-mode)

;; Ctrl-K with no kill
(defun delete-line-no-kill ()
  (interactive)
  (delete-region
   (point)
   (save-excursion (move-end-of-line 1) (point)))
 (delete-char 1)
)
(global-set-key (kbd "C-k") 'delete-line-no-kill)
