(uiop:define-package :llama-cpp
  (:use :cl))

(claw:defwrapper (:claw-llama-cpp/wrapper
                  (:headers "llama.h")
                  (:includes :llama-cpp-includes)
                  (:targets ((:and :x86-64 :linux) "x86_64-pc-linux-gnu"))
                  (:persistent :claw-llama-cpp-bindings
                   :asd-path "../claw-llama-cpp-bindings.asd"
                   :bindings-path "../bindings/")
                  (:include-definitions "^(llama|LLAMA)_\\w+"))
  :in-package :%llama-cpp
  :trim-enum-prefix t
  :recognize-bitfields t
  :recognize-strings t
  :symbolicate-names (:in-pipeline
                      (:by-removing-prefixes "llama_" "LLAMA_")))
