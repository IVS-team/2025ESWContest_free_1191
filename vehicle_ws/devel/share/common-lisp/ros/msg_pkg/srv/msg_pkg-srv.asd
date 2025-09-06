
(cl:in-package :asdf)

(defsystem "msg_pkg-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
               :sensor_msgs-msg
)
  :components ((:file "_package")
    (:file "GetMapCompressed" :depends-on ("_package_GetMapCompressed"))
    (:file "_package_GetMapCompressed" :depends-on ("_package"))
  ))