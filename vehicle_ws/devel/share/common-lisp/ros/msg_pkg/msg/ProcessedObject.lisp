; Auto-generated. Do not edit!


(cl:in-package msg_pkg-msg)


;//! \htmlinclude ProcessedObject.msg.html

(cl:defclass <ProcessedObject> (roslisp-msg-protocol:ros-message)
  ((object_id
    :reader object_id
    :initarg :object_id
    :type cl:integer
    :initform 0)
   (relative_distance
    :reader relative_distance
    :initarg :relative_distance
    :type cl:float
    :initform 0.0)
   (risk_level
    :reader risk_level
    :initarg :risk_level
    :type cl:integer
    :initform 0)
   (relative_position
    :reader relative_position
    :initarg :relative_position
    :type geometry_msgs-msg:Point
    :initform (cl:make-instance 'geometry_msgs-msg:Point))
   (global_position
    :reader global_position
    :initarg :global_position
    :type geometry_msgs-msg:Point
    :initform (cl:make-instance 'geometry_msgs-msg:Point)))
)

(cl:defclass ProcessedObject (<ProcessedObject>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ProcessedObject>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ProcessedObject)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name msg_pkg-msg:<ProcessedObject> is deprecated: use msg_pkg-msg:ProcessedObject instead.")))

(cl:ensure-generic-function 'object_id-val :lambda-list '(m))
(cl:defmethod object_id-val ((m <ProcessedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader msg_pkg-msg:object_id-val is deprecated.  Use msg_pkg-msg:object_id instead.")
  (object_id m))

(cl:ensure-generic-function 'relative_distance-val :lambda-list '(m))
(cl:defmethod relative_distance-val ((m <ProcessedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader msg_pkg-msg:relative_distance-val is deprecated.  Use msg_pkg-msg:relative_distance instead.")
  (relative_distance m))

(cl:ensure-generic-function 'risk_level-val :lambda-list '(m))
(cl:defmethod risk_level-val ((m <ProcessedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader msg_pkg-msg:risk_level-val is deprecated.  Use msg_pkg-msg:risk_level instead.")
  (risk_level m))

(cl:ensure-generic-function 'relative_position-val :lambda-list '(m))
(cl:defmethod relative_position-val ((m <ProcessedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader msg_pkg-msg:relative_position-val is deprecated.  Use msg_pkg-msg:relative_position instead.")
  (relative_position m))

(cl:ensure-generic-function 'global_position-val :lambda-list '(m))
(cl:defmethod global_position-val ((m <ProcessedObject>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader msg_pkg-msg:global_position-val is deprecated.  Use msg_pkg-msg:global_position instead.")
  (global_position m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ProcessedObject>) ostream)
  "Serializes a message object of type '<ProcessedObject>"
  (cl:let* ((signed (cl:slot-value msg 'object_id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'relative_distance))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'risk_level)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'relative_position) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'global_position) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ProcessedObject>) istream)
  "Deserializes a message object of type '<ProcessedObject>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'object_id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'relative_distance) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'risk_level) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'relative_position) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'global_position) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ProcessedObject>)))
  "Returns string type for a message object of type '<ProcessedObject>"
  "msg_pkg/ProcessedObject")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ProcessedObject)))
  "Returns string type for a message object of type 'ProcessedObject"
  "msg_pkg/ProcessedObject")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ProcessedObject>)))
  "Returns md5sum for a message object of type '<ProcessedObject>"
  "a5c038ccad5ad73f55b80d3464c5fdb7")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ProcessedObject)))
  "Returns md5sum for a message object of type 'ProcessedObject"
  "a5c038ccad5ad73f55b80d3464c5fdb7")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ProcessedObject>)))
  "Returns full string definition for message of type '<ProcessedObject>"
  (cl:format cl:nil "int32 object_id~%float64 relative_distance~%int32 risk_level~%geometry_msgs/Point relative_position~%geometry_msgs/Point global_position~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ProcessedObject)))
  "Returns full string definition for message of type 'ProcessedObject"
  (cl:format cl:nil "int32 object_id~%float64 relative_distance~%int32 risk_level~%geometry_msgs/Point relative_position~%geometry_msgs/Point global_position~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ProcessedObject>))
  (cl:+ 0
     4
     8
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'relative_position))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'global_position))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ProcessedObject>))
  "Converts a ROS message object to a list"
  (cl:list 'ProcessedObject
    (cl:cons ':object_id (object_id msg))
    (cl:cons ':relative_distance (relative_distance msg))
    (cl:cons ':risk_level (risk_level msg))
    (cl:cons ':relative_position (relative_position msg))
    (cl:cons ':global_position (global_position msg))
))
