;; Generated by :claw at 2023-10-11T12:45:05.153483Z
(asdf:defsystem #:claw-llama-cpp-bindings
  :description "Bindings generated by claw-llama-cpp"
  :author "CLAW"
  :license "Public domain"
  :defsystem-depends-on (:trivial-features)
  :depends-on (:uiop :cffi :claw-utils)
  :components
  ((:file "bindings/x86_64-pc-linux-gnu" :if-feature
    (:and :x86-64 :linux))))
#-(:or (:and :x86-64 :linux))
(warn "Current platform unrecognized or unsupported by claw-llama-cpp-bindings system")