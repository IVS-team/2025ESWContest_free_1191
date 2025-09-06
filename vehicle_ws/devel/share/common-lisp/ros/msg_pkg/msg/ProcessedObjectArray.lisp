; Auto-generated. Do not edit!


(cl:in-package msg_pkg-msg)


;//! \htmlinclude ProcessedObjectArray.msg.html

(cl:defclass <ProcessedObjectArray> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (vehicle_position
    :reader vehicle_position
    :initarg :vehicle_position
    :type geometry_msgs-msg:Point
    :initform (cl:make-instance 'geometry_msgs-msg:Point))
   (vehicle_yaw
    :reader vehicle_yaw
    :initarg :vehicle_yaw
    :type cl:float
    :initform 0.0)
   (objects
    :reader objects
    :initarg :objects
    :type (cl:vector msg_pkg-msg:ProcessedObject)
   :initform (cl:make-array 0 :element-type 'msg_pkg-msg:ProcessedObject :initial-element (cl:make-instance 'msg_pkg-msg:ProcessedObject))))
)

(cl:defclass ProcessedObjectArray (<ProcessedObjectArray>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ProcessedObjectArray>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ProcessedObjectArray)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name msg_pkg-msg:<ProcessedObjectArray> is deprecated: use msg_pkg-msg:ProcessedObjectArray instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <ProcessedObjectArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader msg_pkg-msg:header-val is deprecated.  Use msg_pkg-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'vehicle_position-val :lambda-list '(m))
(cl:defmethod vehicle_position-val ((m <ProcessedObjectArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader msg_pkg-msg:vehicle_position-val is deprecated.  Use msg_pkg-msg:vehicle_position instead.")
  (vehicle_position m))

(cl:ensure-generic-function 'vehicle_yaw-val :lambda-list '(m))
(cl:defmethod vehicle_yaw-val ((m <ProcessedObjectArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader msg_pkg-msg:vehicle_yaw-val is deprecated.  Use msg_pkg-msg:vehicle_yaw instead.")
  (vehicle_yaw m))

(cl:ensure-generic-function 'objects-val :lambda-list '(m))
(cl:defmethod objects-val ((m <ProcessedObjectArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader msg_pkg-msg:objects-val is deprecated.  Use msg_pkg-msg:objects instead.")
  (objects m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ProcessedObjectArray>) ostream)
  "Serializes a message object of type '<ProcessedObjectArray>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'vehicle_position) ostream)
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'vehicle_yaw))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'objects))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'objects))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ProcessedObjectArray>) istream)
  "Deserializes a message object of type '<ProcessedObjectArray>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'vehicle_position) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vehicle_yaw) (roslisp-utils:decode-double-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'objects) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'objects)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'msg_pkg-msg:ProcessedObject))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ProcessedObjectArray>)))
  "Returns string type for a message object of type '<ProcessedObjectArray>"
  "msg_pkg/ProcessedObjectArray")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ProcessedObjectArray)))
  "Returns string type for a message object of type 'ProcessedObjectArray"
  "msg_pkg/ProcessedObjectArray")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ProcessedObjectArray>)))
  "Returns md5sum for a message object of type '<ProcessedObjectArray>"
  "2878e3c099337b128953ff448b2966e0")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ProcessedObjectArray)))
  "Returns md5sum for a message object of type 'ProcessedObjectArray"
  "2878e3c099337b128953ff448b2966e0")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ProcessedObjectArray>)))
  "Returns full string definition for message of type '<ProcessedObjectArray>"
  (cl:format cl:nil "std_msgs/Header header~%geometry_msgs/Point vehicle_position~%float64 vehicle_yaw~%ProcessedObject[] objects~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: msg_pkg/ProcessedObject~%int32 object_id~%float64 relative_distance~%int32 risk_level~%geometry_msgs/Point relative_position~%geometry_msgs/Point global_position~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ProcessedObjectArray)))
  "Returns full string definition for message of type 'ProcessedObjectArray"
  (cl:format cl:nil "std_msgs/Header header~%geometry_msgs/Point vehicle_position~%float64 vehicle_yaw~%ProcessedObject[] objects~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: msg_pkg/ProcessedObject~%int32 object_id~%float64 relative_distance~%int32 risk_level~%geometry_msgs/Point relative_position~%geometry_msgs/Point global_position~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ProcessedObjectArray>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'vehicle_position))
     8
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'objects) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ProcessedObjectArray>))
  "Converts a ROS message object to a list"
  (cl:list 'ProcessedObjectArray
    (cl:cons ':header (header msg))
    (cl:cons ':vehicle_position (vehicle_position msg))
    (cl:cons ':vehicle_yaw (vehicle_yaw msg))
    (cl:cons ':objects (objects msg))
))
