;;; -*- mode:common-lisp -*-

(cl:in-package #:cl-llama)

(define-foreign-library libllama
  (t (:default "libllama")))

(define-foreign-library libllama-adapter
  (t (:default "libllama-adapter")))

(use-foreign-library libllama)
(use-foreign-library libllama-adapter)

(defun backend-init ()
  #+sbcl
  (sb-int:with-float-traps-masked (:overflow :invalid)
    (%l:backend-init nil))
  #-sbcl
  (%l:backend-init nil))

(defun backend-free ()
  (%l:backend-free))

(defun fill-model-params (model-params params-plist)
  (%l:model-default-params model-params)
  (loop for (field value nil) on params-plist by #'cddr
        do (setf (foreign-slot-value model-params '%l:model-params field) value)))

(defun make-model-params (&optional params-plist)
  (with-foreign-object (model-params '(:struct %l:model-params))
    (fill-model-params model-params params-plist)
    (mem-ref model-params '(:struct %l:model-params))))

(defun load-model (model-file &optional params-plist)
  (with-foreign-object (model-params '(:struct %l:model-params))
    (fill-model-params model-params params-plist)
    (%l:load-model-from-file model-file model-params)))

(defun free-model (model)
  (%l:free-model model))

(defun fill-context-params (context-params params-plist)
  (%l:context-default-params context-params)
  (loop for (field value nil) on params-plist by #'cddr
        do (setf (foreign-slot-value context-params '%l:context-params field) value)))

(defun make-context-params (&optional params-plist)
  (with-foreign-object (context-params '(:struct %l:context-params))
    (fill-context-params context-params params-plist)
    (mem-ref context-params '(:struct %l:context-params))))

(defun create-context (model &optional params-plist)
  (with-foreign-object (context-params '(:struct %l:context-params))
    (fill-context-params context-params params-plist)
    (%l:new-context-with-model model context-params)))

(defun free-context (context)
  (%l:free context))

(defmacro reset-context (context context-params)
  `(let ((model (%l:get-model ,context)))
     (free-context ,context)
     (setf ,context (create-context model ,context-params))))

(defun tokenize (model text n-ctx tokens &key (add-bos t))
  (%l:tokenize model text (length text) tokens n-ctx add-bos))

(defun detokenize (model token &optional strip-space)
  "Turn token into string. Optionally strip leading space."
  (let ((length (- (%l:token-to-piece model token (null-pointer) 0))))
    (with-foreign-object (buf :char (1+ length))
      (%l:token-to-piece model token buf length)
      (setf (mem-aref buf :char length) 0)
      (let ((initial-index (if (and strip-space (= (mem-aref buf :char) 32)) 1 0)))
        (foreign-string-to-lisp buf :offset initial-index
                                    :count (- length initial-index))))))
