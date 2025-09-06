;; Auto-generated. Do not edit!


(when (boundp 'msg_pkg::DetectedObject)
  (if (not (find-package "MSG_PKG"))
    (make-package "MSG_PKG"))
  (shadow 'DetectedObject (find-package "MSG_PKG")))
(unless (find-package "MSG_PKG::DETECTEDOBJECT")
  (make-package "MSG_PKG::DETECTEDOBJECT"))

(in-package "ROS")
;;//! \htmlinclude DetectedObject.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass msg_pkg::DetectedObject
  :super ros::object
  :slots (_object_id _global_position ))

(defmethod msg_pkg::DetectedObject
  (:init
   (&key
    ((:object_id __object_id) 0)
    ((:global_position __global_position) (instance geometry_msgs::Point :init))
    )
   (send-super :init)
   (setq _object_id (round __object_id))
   (setq _global_position __global_position)
   self)
  (:object_id
   (&optional __object_id)
   (if __object_id (setq _object_id __object_id)) _object_id)
  (:global_position
   (&rest __global_position)
   (if (keywordp (car __global_position))
       (send* _global_position __global_position)
     (progn
       (if __global_position (setq _global_position (car __global_position)))
       _global_position)))
  (:serialization-length
   ()
   (+
    ;; int32 _object_id
    4
    ;; geometry_msgs/Point _global_position
    (send _global_position :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _object_id
       (write-long _object_id s)
     ;; geometry_msgs/Point _global_position
       (send _global_position :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _object_id
     (setq _object_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; geometry_msgs/Point _global_position
     (send _global_position :deserialize buf ptr-) (incf ptr- (send _global_position :serialization-length))
   ;;
   self)
  )

(setf (get msg_pkg::DetectedObject :md5sum-) "08583d37b8e045278bf90fa68ff7e74d")
(setf (get msg_pkg::DetectedObject :datatype-) "msg_pkg/DetectedObject")
(setf (get msg_pkg::DetectedObject :definition-)
      "int32 object_id
geometry_msgs/Point global_position

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

")



(provide :msg_pkg/DetectedObject "08583d37b8e045278bf90fa68ff7e74d")


