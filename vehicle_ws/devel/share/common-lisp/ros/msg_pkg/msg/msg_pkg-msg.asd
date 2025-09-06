
(cl:in-package :asdf)

(defsystem "msg_pkg-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
               :std_msgs-msg
)
  :components ((:file "_package")
    (:file "DetectedObject" :depends-on ("_package_DetectedObject"))
    (:file "_package_DetectedObject" :depends-on ("_package"))
    (:file "DetectedObjectArray" :depends-on ("_package_DetectedObjectArray"))
    (:file "_package_DetectedObjectArray" :depends-on ("_package"))
    (:file "ProcessedObject" :depends-on ("_package_ProcessedObject"))
    (:file "_package_ProcessedObject" :depends-on ("_package"))
    (:file "ProcessedObjectArray" :depends-on ("_package_ProcessedObjectArray"))
    (:file "_package_ProcessedObjectArray" :depends-on ("_package"))
  ))