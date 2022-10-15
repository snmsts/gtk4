(uiop/package:define-package :gtk4/init
  (:use :cl)
  (:export
   :*gtk*
   :*gdk*
   :*gio*
   :*gobject*
   :*pangocairo*
   :*pango*
   :*cairo*
   :setup-namespace
   :init
   ))

(in-package :gtk4/init)
;;;don't edit above

(defvar *gtk* nil)
(defvar *gdk* nil)
(defvar *gio* nil)
(defvar *gobject* nil)
(defvar *pangocairo* nil)
(defvar *pango* nil)
(defvar *cairo* nil)

(defun init ()
  (gir:invoke (*gtk* :init)))

(defun setup-namespace ()
  (unless *gtk*
    (setf *gtk* (gir:require-namespace "Gtk" "4.0")))
  (unless *gdk* 
    (setf *gdk* (gir:require-namespace "Gdk" "4.0")))
  (unless *gio*
    (setf *gio* (gir:require-namespace "Gio" "2.0")))
  (unless *gobject*
    (setf *gobject* (gir:require-namespace "GObject" "2.0")))
  (unless *pangocairo*
    (setf *pangocairo* (gir:require-namespace "PangoCairo" "1.0")))
  (unless *pango*
    (setf *pango* (gir:require-namespace "Pango" "1.0")))
  (unless *cairo*
    (setf *cairo* (gir:require-namespace "cairo" "1.0")))
  t)
