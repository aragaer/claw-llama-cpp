;;; -*- mode:common-lisp -*-

(cl:defpackage :cl-llama
  (:use :cl :cffi)
  (:local-nicknames (:%l :%llama-cpp))
  (:export #:backend-init
           #:backend-free

           #:make-model-params
           #:load-model
           #:free-model

           #:make-context-params
           #:create-context
           #:free-context
           #:reset-context

           #:tokenize
           #:detokenize))
