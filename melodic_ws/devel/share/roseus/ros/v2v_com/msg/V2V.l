;; Auto-generated. Do not edit!


(when (boundp 'v2v_com::V2V)
  (if (not (find-package "V2V_COM"))
    (make-package "V2V_COM"))
  (shadow 'V2V (find-package "V2V_COM")))
(unless (find-package "V2V_COM::V2V")
  (make-package "V2V_COM::V2V"))

(in-package "ROS")
;;//! \htmlinclude V2V.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass v2v_com::V2V
  :super ros::object
  :slots (_header _a_global _a_yaw _obstacles ))

(defmethod v2v_com::V2V
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:a_global __a_global) (instance geometry_msgs::Point :init))
    ((:a_yaw __a_yaw) 0.0)
    ((:obstacles __obstacles) (let (r) (dotimes (i 0) (push (instance v2v_com::ObstacleData :init) r)) r))
    )
   (send-super :init)
   (setq _header __header)
   (setq _a_global __a_global)
   (setq _a_yaw (float __a_yaw))
   (setq _obstacles __obstacles)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:a_global
   (&rest __a_global)
   (if (keywordp (car __a_global))
       (send* _a_global __a_global)
     (progn
       (if __a_global (setq _a_global (car __a_global)))
       _a_global)))
  (:a_yaw
   (&optional __a_yaw)
   (if __a_yaw (setq _a_yaw __a_yaw)) _a_yaw)
  (:obstacles
   (&rest __obstacles)
   (if (keywordp (car __obstacles))
       (send* _obstacles __obstacles)
     (progn
       (if __obstacles (setq _obstacles (car __obstacles)))
       _obstacles)))
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; geometry_msgs/Point _a_global
    (send _a_global :serialization-length)
    ;; float32 _a_yaw
    4
    ;; v2v_com/ObstacleData[] _obstacles
    (apply #'+ (send-all _obstacles :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; geometry_msgs/Point _a_global
       (send _a_global :serialize s)
     ;; float32 _a_yaw
       (sys::poke _a_yaw (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; v2v_com/ObstacleData[] _obstacles
     (write-long (length _obstacles) s)
     (dolist (elem _obstacles)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; geometry_msgs/Point _a_global
     (send _a_global :deserialize buf ptr-) (incf ptr- (send _a_global :serialization-length))
   ;; float32 _a_yaw
     (setq _a_yaw (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; v2v_com/ObstacleData[] _obstacles
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _obstacles (let (r) (dotimes (i n) (push (instance v2v_com::ObstacleData :init) r)) r))
     (dolist (elem- _obstacles)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get v2v_com::V2V :md5sum-) "100a5c98016f608ae0d405a275ce49f4")
(setf (get v2v_com::V2V :datatype-) "v2v_com/V2V")
(setf (get v2v_com::V2V :definition-)
      "# 종합 데이터
std_msgs/Header header
geometry_msgs/Point a_global
float32 a_yaw
v2v_com/ObstacleData[] obstacles
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
MSG: v2v_com/ObstacleData
# 개별 장애물 데이터
geometry_msgs/Point obstacle_global
float32 ob_height
float32 ob_width
float32 a_ob_distance
")



(provide :v2v_com/V2V "100a5c98016f608ae0d405a275ce49f4")


