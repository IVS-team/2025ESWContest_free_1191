;; Auto-generated. Do not edit!


(when (boundp 'msg_pkg::ProcessedObjectArray)
  (if (not (find-package "MSG_PKG"))
    (make-package "MSG_PKG"))
  (shadow 'ProcessedObjectArray (find-package "MSG_PKG")))
(unless (find-package "MSG_PKG::PROCESSEDOBJECTARRAY")
  (make-package "MSG_PKG::PROCESSEDOBJECTARRAY"))

(in-package "ROS")
;;//! \htmlinclude ProcessedObjectArray.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass msg_pkg::ProcessedObjectArray
  :super ros::object
  :slots (_header _vehicle_position _vehicle_yaw _objects ))

(defmethod msg_pkg::ProcessedObjectArray
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:vehicle_position __vehicle_position) (instance geometry_msgs::Point :init))
    ((:vehicle_yaw __vehicle_yaw) 0.0)
    ((:objects __objects) (let (r) (dotimes (i 0) (push (instance msg_pkg::ProcessedObject :init) r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _vehicle_position __vehicle_position)
   (setq _vehicle_yaw (float __vehicle_yaw))
   (setq _objects __objects)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:vehicle_position
   (&rest __vehicle_position)
   (if (keywordp (car __vehicle_position))
       (send* _vehicle_position __vehicle_position)
     (progn
       (if __vehicle_position (setq _vehicle_position (car __vehicle_position)))
       _vehicle_position)))
  (:vehicle_yaw
   (&optional __vehicle_yaw)
   (if __vehicle_yaw (setq _vehicle_yaw __vehicle_yaw)) _vehicle_yaw)
  (:objects
   (&rest __objects)
   (if (keywordp (car __objects))
       (send* _objects __objects)
     (progn
       (if __objects (setq _objects (car __objects)))
       _objects)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; geometry_msgs/Point _vehicle_position
    (send _vehicle_position :serialization-length)
    ;; float64 _vehicle_yaw
    8
    ;; msg_pkg/ProcessedObject[] _objects
    (apply #'+ (send-all _objects :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; geometry_msgs/Point _vehicle_position
       (send _vehicle_position :serialize s)
     ;; float64 _vehicle_yaw
       (sys::poke _vehicle_yaw (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; msg_pkg/ProcessedObject[] _objects
     (write-long (length _objects) s)
     (dolist (elem _objects)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; geometry_msgs/Point _vehicle_position
     (send _vehicle_position :deserialize buf ptr-) (incf ptr- (send _vehicle_position :serialization-length))
   ;; float64 _vehicle_yaw
     (setq _vehicle_yaw (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; msg_pkg/ProcessedObject[] _objects
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _objects (let (r) (dotimes (i n) (push (instance msg_pkg::ProcessedObject :init) r)) r))
     (dolist (elem- _objects)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get msg_pkg::ProcessedObjectArray :md5sum-) "2878e3c099337b128953ff448b2966e0")
(setf (get msg_pkg::ProcessedObjectArray :datatype-) "msg_pkg/ProcessedObjectArray")
(setf (get msg_pkg::ProcessedObjectArray :definition-)
      "std_msgs/Header header
geometry_msgs/Point vehicle_position
float64 vehicle_yaw
ProcessedObject[] objects

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: msg_pkg/ProcessedObject
int32 object_id
float64 relative_distance
int32 risk_level
geometry_msgs/Point relative_position
geometry_msgs/Point global_position
")



(provide :msg_pkg/ProcessedObjectArray "2878e3c099337b128953ff448b2966e0")


