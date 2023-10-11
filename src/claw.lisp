(cl:defpackage :llama-cpp
  (:use :cl)
  (:export))

(cl:in-package :llama-cpp)

(claw:defwrapper (:claw-llama-cpp
                  (:system :claw-llama-cpp/wrapper)
                  (:headers "llama.h")
                  (:includes :llama-cpp-includes)
                  (:targets ((:and :x86-64 :linux) "x86_64-pc-linux-gnu"))
                  (:persistent t
                   :bindings-path "../bindings/"
                   :depends-on (:claw-utils))
                  (:language :c++)
                  (:include-definitions "llama_backend_init"))
  :in-package :%llama-cpp
  :trim-enum-prefix t
  :recognize-bitfields t
  :recognize-strings t
  :symbolicate-names (:in-pipeline
                      (:by-removing-prefixes "llama_" "LLAMA_")))
