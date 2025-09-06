; Auto-generated. Do not edit!


(cl:in-package msg_pkg-msg)


;//! \htmlinclude DetectedObject.msg.html

(cl:defclass <DetectedObject> (roslisp-msg-protocol:ros-message)
  ((object_id
    :reader object_id
    :initarg :object_id
    :type cl:integer
    :initform 0)
   (global_position
    :reader global_position
    :initarg :global_position
    :type geometry_msgs-msg:Point
    :initform (cl:make-instance 'geometry_msgs-msg:Point)))
)

(cl:defclass DetectedObject (<DetectedObject>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DetectedObject>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DetectedObject)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name msg_pkg-msg:<DetectedObject> is deprecated: use msg_pkg-msg:DetectedObject instead.")))

(cl:ensure-generic-function 'object_id-val :lambda-list '(m))
(cl:defmethod object_id-val ((m <DetectedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader msg_pkg-msg:object_id-val is deprecated.  Use msg_pkg-msg:object_id instead.")
  (object_id m))

(cl:ensure-generic-function 'global_position-val :lambda-list '(m))
(cl:defmethod global_position-val ((m <DetectedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader msg_pkg-msg:global_position-val is deprecated.  Use msg_pkg-msg:global_position instead.")
  (global_position m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DetectedObject>) ostream)
  "Serializes a message object of type '<DetectedObject>"
  (cl:let* ((signed (cl:slot-value msg 'object_id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'global_position) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DetectedObject>) istream)
  "Deserializes a message object of type '<DetectedObject>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'object_id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'global_position) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DetectedObject>)))
  "Returns string type for a message object of type '<DetectedObject>"
  "msg_pkg/DetectedObject")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DetectedObject)))
  "Returns string type for a message object of type 'DetectedObject"
  "msg_pkg/DetectedObject")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DetectedObject>)))
  "Returns md5sum for a message object of type '<DetectedObject>"
  "08583d37b8e045278bf90fa68ff7e74d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DetectedObject)))
  "Returns md5sum for a message object of type 'DetectedObject"
  "08583d37b8e045278bf90fa68ff7e74d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DetectedObject>)))
  "Returns full string definition for message of type '<DetectedObject>"
  (cl:format cl:nil "int32 object_id~%geometry_msgs/Point global_position~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DetectedObject)))
  "Returns full string definition for message of type 'DetectedObject"
  (cl:format cl:nil "int32 object_id~%geometry_msgs/Point global_position~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DetectedObject>))
  (cl:+ 0
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'global_position))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DetectedObject>))
  "Converts a ROS message object to a list"
  (cl:list 'DetectedObject
    (cl:cons ':object_id (object_id msg))
    (cl:cons ':global_position (global_position msg))
))
