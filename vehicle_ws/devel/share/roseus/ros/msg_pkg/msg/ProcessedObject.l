;; Auto-generated. Do not edit!


(when (boundp 'msg_pkg::ProcessedObject)
  (if (not (find-package "MSG_PKG"))
    (make-package "MSG_PKG"))
  (shadow 'ProcessedObject (find-package "MSG_PKG")))
(unless (find-package "MSG_PKG::PROCESSEDOBJECT")
  (make-package "MSG_PKG::PROCESSEDOBJECT"))

(in-package "ROS")
;;//! \htmlinclude ProcessedObject.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass msg_pkg::ProcessedObject
  :super ros::object
  :slots (_object_id _relative_distance _risk_level _relative_position _global_position ))

(defmethod msg_pkg::ProcessedObject
  (:init
   (&key
    ((:object_id __object_id) 0)
    ((:relative_distance __relative_distance) 0.0)
    ((:risk_level __risk_level) 0)
    ((:relative_position __relative_position) (instance geometry_msgs::Point :init))
    ((:global_position __global_position) (instance geometry_msgs::Point :init))
    )
   (send-super :init)
   (setq _object_id (round __object_id))
   (setq _relative_distance (float __relative_distance))
   (setq _risk_level (round __risk_level))
   (setq _relative_position __relative_position)
   (setq _global_position __global_position)
   self)
  (:object_id
   (&optional __object_id)
   (if __object_id (setq _object_id __object_id)) _object_id)
  (:relative_distance
   (&optional __relative_distance)
   (if __relative_distance (setq _relative_distance __relative_distance)) _relative_distance)
  (:risk_level
   (&optional __risk_level)
   (if __risk_level (setq _risk_level __risk_level)) _risk_level)
  (:relative_position
   (&rest __relative_position)
   (if (keywordp (car __relative_position))
       (send* _relative_position __relative_position)
     (progn
       (if __relative_position (setq _relative_position (car __relative_position)))
       _relative_position)))
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
    ;; float64 _relative_distance
    8
    ;; int32 _risk_level
    4
    ;; geometry_msgs/Point _relative_position
    (send _relative_position :serialization-length)
    ;; geometry_msgs/Point _global_position
    (send _global_position :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _object_id
       (write-long _object_id s)
     ;; float64 _relative_distance
       (sys::poke _relative_distance (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; int32 _risk_level
       (write-long _risk_level s)
     ;; geometry_msgs/Point _relative_position
       (send _relative_position :serialize s)
     ;; geometry_msgs/Point _global_position
       (send _global_position :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _object_id
     (setq _object_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float64 _relative_distance
     (setq _relative_distance (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; int32 _risk_level
     (setq _risk_level (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; geometry_msgs/Point _relative_position
     (send _relative_position :deserialize buf ptr-) (incf ptr- (send _relative_position :serialization-length))
   ;; geometry_msgs/Point _global_position
     (send _global_position :deserialize buf ptr-) (incf ptr- (send _global_position :serialization-length))
   ;;
   self)
  )

(setf (get msg_pkg::ProcessedObject :md5sum-) "a5c038ccad5ad73f55b80d3464c5fdb7")
(setf (get msg_pkg::ProcessedObject :datatype-) "msg_pkg/ProcessedObject")
(setf (get msg_pkg::ProcessedObject :definition-)
      "int32 object_id
float64 relative_distance
int32 risk_level
geometry_msgs/Point relative_position
geometry_msgs/Point global_position
================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

")



(provide :msg_pkg/ProcessedObject "a5c038ccad5ad73f55b80d3464c5fdb7")


