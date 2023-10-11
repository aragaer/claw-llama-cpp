#!/bin/sh
exec ~/Projects/ccl/lx86cl64 -Q -n -b <<EOF
(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp" (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))

(ql:quickload :cffi :silent t)
(cffi:load-foreign-library (merge-pathnames
                            "Projects/libresect/build/resect/libresect.so"
                            (user-homedir-pathname)))

(push (truename ".") asdf:*central-registry*)
(pushnew :claw-regen-adapter *features*)

(asdf:load-system :claw-llama-cpp/wrapper)
(claw:generate-wrapper :claw-llama-cpp)
EOF
