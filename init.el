(defcustom Kuautli-el-home "~/.emacs.d/Kuautli-el"
 "Establece la carpeta de donde se obtendran las configuraciones del 
paquete kuautli-el")

(defcustom Kuatli-el-toolbar? t "Bandera para activar el toolbar de kuautli")
(defcustom Kuatli-el-theme? t "Bandera para activar el tema de colores de kuautli")

(setq inhibit-splash-screen t) ;; Deshabilita pantalla de inicio
(put 'scroll-left 'disabled nil) ;; Deshabilita el scroll de lado izquierdo
(put 'erase-buffer 'disabled nil) ;; activa la funcion de borrar todo el bufer
(scroll-bar-mode t) ;; Habilita a barra de desplasamiento



(custom-set-variables
 ;; Propiedades de fill-column-indicator
 '(fci-rule-color "#555555")
 '(fci-rule-width 4)
 '(tabbar-separator (quote (0.4))))


;; Cambia el acceso para clasico modo de buffer por ibuffer 
(global-set-key (kbd "C-x C-b") 'ibuffer)

(show-paren-mode 1) ;; resalta los parentesis opuestos
(column-number-mode 1) ;; muestra la columna actual en la linea de modo

(cua-mode 1) ;; activa el modo cua - copiar/pegar/cortar con las combinaciones
             ;; teclas mas conocidad - C-c, C-x, C-v

(ido-mode 1) ;; Activa el modo ido, para un interactivo modo de apertura
             ;; y seleccion de ficheros o buffers



(display-time) ;; Muestra la hora actual en la linea de modo

(setq indent-tabs-mode nil) ;; Desactiva el tabulador
(setq tab-width 4) ;; Establece que cuando se presione TAB se avanzara 4 espacios


;; Combinación de teclas que ayuda a visualizar el contenido
;; del kill-ring
(global-set-key (kbd "C-c y") '(lambda ()
				"Muestra el kill-ring"
				(interactive)
				(popup-menu 'yank-menu)))

(let ((default-directory Kuautli-el-home))
  (normal-top-level-add-subdirs-to-load-path)

  ;; ;; Configuraciones popwin
  ;; (require 'popwin)
  ;; (setq display-buffer-function ;; modo que permite la creacion de ventanas
  ;; 	'popwin:display-buffer) ;; para mensajes emergentes


  ;; Configuraciones autopair
  (require 'autopair)
  (autopair-global-mode)
  
  ;; Configuraciones yasnippet
  (require 'yasnippet)
  (yas-global-mode 1)

  ;; regla de 80 columnas
  (require 'fill-column-indicator)
  (setq-default fill-column 80)

  (require 'zlc)

  (let ((map minibuffer-local-map))
    ;;; like menu select
    (define-key map (kbd "<down>")  'zlc-select-next-vertical)
    (define-key map (kbd "<up>")    'zlc-select-previous-vertical)
    (define-key map (kbd "<right>") 'zlc-select-next)
    (define-key map (kbd "<left>")  'zlc-select-previous)

    ;;; reset selection
    (define-key map (kbd "C-c") 'zlc-reset))

  ;; tabbar
  (require 'tabbar)
  (global-set-key (kbd "C-S-p") 'tabbar-backward-group)
  (global-set-key (kbd "C-S-n") 'tabbar-forward-group)
  (global-set-key (kbd "C-<") 'tabbar-backward)
  (global-set-key (kbd "C->") 'tabbar-forward) ;; tabbar.el, put all the buffers on the tabs.

  ;; (load-file "moz.el")
  ;; (autoload 'moz-minor-mode "moz" "Mozilla Minor and Inferior Mozilla Modes" t)

  ;; (add-hook 'html-mode-hook '(lambda () (define-key html-mode-map (kbd "C-x C-s")
  ;;               (lambda ()
  ;;                 (interactive)
  ;;   	  (save-buffer)
  ;;                 (comint-send-string (inferior-moz-process)
  ;;                                     "BrowserReload();")))))


  (load-file "fullscreen.el")


  (setq work-time-list '(menu-bar-mode tool-bar-mode))
  (defun work-time ()
    (interactive)
    (mapcar (lambda (modo) (funcall modo -1)) work-time-list))

  (defun nowork-time ()
    (interactive)
    (mapcar (lambda (modo) (funcall modo 1)) work-time-list))

  (load-file "go-mode-load.el")
  (require 'go-mode-load)

  (require 'package)
  (add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

  (if Kuatli-el-theme?
      (progn ;; Establece los espacios de un solo color
	(custom-set-faces
	 '(whitespace-hspace ((t (:foreground "darkgray"))))
	 '(whitespace-space ((t (:foreground "darkgray"))))
	 '(whitespace-tab ((t (:foreground "darkgray"))))
	 '(tabbar-button ((t (:inherit tabbar-default :box (:line-width 1 :color "black" :style released-button)))))
	 '(tabbar-button-highlight ((t (:inherit tabbar-default :background "gray"))))
	 '(tabbar-default ((t (:inherit variable-pitch :background "gray50" :foreground "light gray" :height 0.8))))
	 '(tabbar-highlight ((t (:background "gray" :foreground "black" :underline t))))
	 '(tabbar-selected ((t (:inherit tabbar-default :background "light gray" :foreground "blue" :box (:line-width 1 :color "white smoke" :style pressed-button)))))
	 '(tabbar-separator ((t (:inherit tabbar-default :height 1))))
	 '(tabbar-unselected ((t (:inherit tabbar-default :box (:line-width 1 :color "dim gray" :style released-button))))))
	(load-theme 'wombat))) ;; Estable el tema por defecto

  (if Kuatli-el-toolbar?
      (progn (load-file "Kuautli-el-toolbar.el")
	     (require 'Kuautli-el-toolbar)))


  (add-to-list 'load-path "emacs-dirtree")
  (load-file "tree-mode.el")
  (load-file "windata.el")
  (require 'dirtree)

  (add-to-list 'load-path "git-modes")
  (require 'git-commit-mode)
  (require 'gitignore-mode)
  (require 'gitconfig-mode)


  (add-to-list 'load-path "org-bullets")
  (require 'org-bullets)
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

  (add-to-list 'load-path "mark-multiple.el")
  (require 'mark-multiple)

  (add-to-list 'load-path "ibuffer-vc")
  (require 'ibuffer-vc)
  (add-hook 'ibuffer-hook (lambda ()
			    (ibuffer-vc-set-filter-groups-by-vc-root)
			    (unless (eq ibuffer-sorting-mode 'alphabetic)
			      (ibuffer-do-sort-by-alphabetic))))


  (load-file "dash.el/dash.el")
  (require 'dash)

  (load-file "s.el/s.el")
  (require 's)

  (add-to-list 'load-path "projectile")
  (load-file "projectile/projectile.el")
  (require 'projectile)
)
