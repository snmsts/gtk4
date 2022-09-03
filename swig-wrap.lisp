(defpackage :gtk4/swig-wrap
  (:use :cl)
  (:export :define-constant
           :defanonenum
           :swig-lispify))

(in-package :gtk4/swig-wrap)

(defmacro define-constant (name value &optional doc)
  `(defconstant ,name (if (boundp ',name) (symbol-value ',name) ,value)
     ,@(when doc (list doc))))

(defmacro defanonenum (&body enums)
   "Converts anonymous enums to defconstants."
  `(progn ,@(loop for value in enums
                  for index = 0 then (1+ index)
                  when (listp value) do (setf index (second value)
                                              value (first value))
                  collect `(defconstant ,value ,index))))

(eval-when (:compile-toplevel :load-toplevel)
  (unless (fboundp 'swig-lispify)
    (defun swig-lispify (name flag &optional (package *package*))
      (labels ((helper (lst last rest &aux (c (car lst)))
                    (cond
                      ((null lst)
                       rest)
                      ((upper-case-p c)
                       (helper (cdr lst) 'upper
                               (case last
                                 ((lower digit) (list* c #\- rest))
                                 (t (cons c rest)))))
                      ((lower-case-p c)
                       (helper (cdr lst) 'lower (cons (char-upcase c) rest)))
                      ((digit-char-p c)
                       (helper (cdr lst) 'digit 
                               (case last
                                 ((upper lower) (list* c #\- rest))
                                 (t (cons c rest)))))
                      ((char-equal c #\_)
                       (helper (cdr lst) '_ (cons #\- rest)))
                      (t
                       (error "Invalid character: ~A" c)))))
        (let ((fix (case flag
                        ((constant enumvalue) "+")
                        (variable "*")
                        (t ""))))
          (intern
           (concatenate
            'string
            fix
            (nreverse (helper (concatenate 'list name) nil nil))
            fix)
           package))))))
