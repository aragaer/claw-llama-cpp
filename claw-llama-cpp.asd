(asdf:defsystem :claw-llama-cpp
  :description "Wrapper for llama.cpp"
  :version "0.0.1"
  :author "aragaer"
  :mailto "aragaer@gmail.com"
  :license "MIT"
  :depends-on (:cffi :claw-llama-cpp-bindings)
  :components ((:file "src/package")
               (:file "src/llama")))

(asdf:defsystem :claw-llama-cpp/wrapper
  :description "Wrapper for llama.cpp"
  :version "0.0.1"
  :author "aragaer"
  :mailto "aragaer@gmail.com"
  :license "MIT"
  :depends-on (:claw-utils :claw)
  :serial t
  :components ((:file "src/claw")
               (:module :llama-cpp-includes :pathname "src/lib/llama.cpp/")))
