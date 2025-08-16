; Auto-generated. Do not edit!


(cl:in-package v2v_com-msg)


;//! \htmlinclude V2V.msg.html

(cl:defclass <V2V> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (a_global
    :reader a_global
    :initarg :a_global
    :type geometry_msgs-msg:Point
    :initform (cl:make-instance 'geometry_msgs-msg:Point))
   (a_yaw
    :reader a_yaw
    :initarg :a_yaw
    :type cl:float
    :initform 0.0)
   (obstacles
    :reader obstacles
    :initarg :obstacles
    :type (cl:vector v2v_com-msg:ObstacleData)
   :initform (cl:make-array 0 :element-type 'v2v_com-msg:ObstacleData :initial-element (cl:make-instance 'v2v_com-msg:ObstacleData))))
)

(cl:defclass V2V (<V2V>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <V2V>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'V2V)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name v2v_com-msg:<V2V> is deprecated: use v2v_com-msg:V2V instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <V2V>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader v2v_com-msg:header-val is deprecated.  Use v2v_com-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'a_global-val :lambda-list '(m))
(cl:defmethod a_global-val ((m <V2V>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader v2v_com-msg:a_global-val is deprecated.  Use v2v_com-msg:a_global instead.")
  (a_global m))

(cl:ensure-generic-function 'a_yaw-val :lambda-list '(m))
(cl:defmethod a_yaw-val ((m <V2V>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader v2v_com-msg:a_yaw-val is deprecated.  Use v2v_com-msg:a_yaw instead.")
  (a_yaw m))

(cl:ensure-generic-function 'obstacles-val :lambda-list '(m))
(cl:defmethod obstacles-val ((m <V2V>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader v2v_com-msg:obstacles-val is deprecated.  Use v2v_com-msg:obstacles instead.")
  (obstacles m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <V2V>) ostream)
  "Serializes a message object of type '<V2V>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'a_global) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'a_yaw))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'obstacles))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'obstacles))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <V2V>) istream)
  "Deserializes a message object of type '<V2V>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'a_global) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'a_yaw) (roslisp-utils:decode-single-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'obstacles) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'obstacles)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'v2v_com-msg:ObstacleData))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<V2V>)))
  "Returns string type for a message object of type '<V2V>"
  "v2v_com/V2V")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'V2V)))
  "Returns string type for a message object of type 'V2V"
  "v2v_com/V2V")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<V2V>)))
  "Returns md5sum for a message object of type '<V2V>"
  "100a5c98016f608ae0d405a275ce49f4")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'V2V)))
  "Returns md5sum for a message object of type 'V2V"
  "100a5c98016f608ae0d405a275ce49f4")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<V2V>)))
  "Returns full string definition for message of type '<V2V>"
  (cl:format cl:nil "# 종합 데이터~%std_msgs/Header header~%geometry_msgs/Point a_global~%float32 a_yaw~%v2v_com/ObstacleData[] obstacles~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: v2v_com/ObstacleData~%# 개별 장애물 데이터~%geometry_msgs/Point obstacle_global~%float32 ob_height~%float32 ob_width~%float32 a_ob_distance~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'V2V)))
  "Returns full string definition for message of type 'V2V"
  (cl:format cl:nil "# 종합 데이터~%std_msgs/Header header~%geometry_msgs/Point a_global~%float32 a_yaw~%v2v_com/ObstacleData[] obstacles~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: v2v_com/ObstacleData~%# 개별 장애물 데이터~%geometry_msgs/Point obstacle_global~%float32 ob_height~%float32 ob_width~%float32 a_ob_distance~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <V2V>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'a_global))
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'obstacles) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <V2V>))
  "Converts a ROS message object to a list"
  (cl:list 'V2V
    (cl:cons ':header (header msg))
    (cl:cons ':a_global (a_global msg))
    (cl:cons ':a_yaw (a_yaw msg))
    (cl:cons ':obstacles (obstacles msg))
))
