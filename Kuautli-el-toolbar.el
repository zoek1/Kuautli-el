(load-file "toolbar-x.el")
(require 'custom)
(require 'toolbar-x)


(defgroup Kuautli-el-toolbar nil 
  "Grupo de elementos en la barra de herramientas")

(defcustom Kuautli-el-buttons
  '(new-file open-file dired kill-buffer save-buffer sep cut copy paste undo  search-forward 
	     terminal package)
  "Grupo de elementos en la barra de herramientas"
  :group 'Kuautli-el-toolbar)

(defcustom Kuautli-el-toolbar-directory 
  (expand-file-name "img" Kuautli-el-home)
  "Directorio de imagenes del toolbar"
  :group 'Kuautli-el-toolbar)

(defcustom Kuautli-el-toolbar-alist 
  '((terminal :image "terminal" :command (shell))
    (package  :image "packagem" :command (list-packages))
    (separator :image "sep" :command t :enable nil :help ""))
  "Lista de elementos que conforman la barra de herramientas de Kuautli-el" 
  :group 'Kuautli-el-toolbar)

(setq Kuautli-el-toolbar-list 
   (let ((botones))
     (mapcar (lambda (boton) 
	       (append botones (car boton))) Kuautli-el-toolbar-alist)))

;; Agregar la ruta a la lista de directorio de imagenes del sistema
(add-to-list 'toolbarx-image-path Kuautli-el-toolbar-directory)

;; (toolbarx-install-toolbar Kuautli-el-toolbar-list Kuautli-el-toolbar-alist t)
(toolbarx-install-toolbar Kuautli-el-buttons  (dolist (iconsdefault toolbarx-default-toolbar-meaning-alist Kuautli-el-toolbar-alist)
						(setq Kuautli-el-toolbar-alist(cons iconsdefault Kuautli-el-toolbar-alist ))) t)

(provide 'Kuautli-el-toolbar)
