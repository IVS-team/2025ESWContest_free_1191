
(cl:in-package :asdf)

(defsystem "v2v_com-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
               :std_msgs-msg
)
  :components ((:file "_package")
    (:file "ObstacleData" :depends-on ("_package_ObstacleData"))
    (:file "_package_ObstacleData" :depends-on ("_package"))
    (:file "V2V" :depends-on ("_package_V2V"))
    (:file "_package_V2V" :depends-on ("_package"))
  ))