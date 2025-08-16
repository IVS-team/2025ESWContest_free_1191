; Auto-generated. Do not edit!


(cl:in-package v2v_com-msg)


;//! \htmlinclude ObstacleData.msg.html

(cl:defclass <ObstacleData> (roslisp-msg-protocol:ros-message)
  ((obstacle_global
    :reader obstacle_global
    :initarg :obstacle_global
    :type geometry_msgs-msg:Point
    :initform (cl:make-instance 'geometry_msgs-msg:Point))
   (ob_height
    :reader ob_height
    :initarg :ob_height
    :type cl:float
    :initform 0.0)
   (ob_width
    :reader ob_width
    :initarg :ob_width
    :type cl:float
    :initform 0.0)
   (a_ob_distance
    :reader a_ob_distance
    :initarg :a_ob_distance
    :type cl:float
    :initform 0.0))
)

(cl:defclass ObstacleData (<ObstacleData>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ObstacleData>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ObstacleData)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name v2v_com-msg:<ObstacleData> is deprecated: use v2v_com-msg:ObstacleData instead.")))

(cl:ensure-generic-function 'obstacle_global-val :lambda-list '(m))
(cl:defmethod obstacle_global-val ((m <ObstacleData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader v2v_com-msg:obstacle_global-val is deprecated.  Use v2v_com-msg:obstacle_global instead.")
  (obstacle_global m))

(cl:ensure-generic-function 'ob_height-val :lambda-list '(m))
(cl:defmethod ob_height-val ((m <ObstacleData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader v2v_com-msg:ob_height-val is deprecated.  Use v2v_com-msg:ob_height instead.")
  (ob_height m))

(cl:ensure-generic-function 'ob_width-val :lambda-list '(m))
(cl:defmethod ob_width-val ((m <ObstacleData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader v2v_com-msg:ob_width-val is deprecated.  Use v2v_com-msg:ob_width instead.")
  (ob_width m))

(cl:ensure-generic-function 'a_ob_distance-val :lambda-list '(m))
(cl:defmethod a_ob_distance-val ((m <ObstacleData>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader v2v_com-msg:a_ob_distance-val is deprecated.  Use v2v_com-msg:a_ob_distance instead.")
  (a_ob_distance m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ObstacleData>) ostream)
  "Serializes a message object of type '<ObstacleData>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'obstacle_global) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'ob_height))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'ob_width))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'a_ob_distance))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ObstacleData>) istream)
  "Deserializes a message object of type '<ObstacleData>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'obstacle_global) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'ob_height) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'ob_width) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'a_ob_distance) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ObstacleData>)))
  "Returns string type for a message object of type '<ObstacleData>"
  "v2v_com/ObstacleData")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ObstacleData)))
  "Returns string type for a message object of type 'ObstacleData"
  "v2v_com/ObstacleData")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ObstacleData>)))
  "Returns md5sum for a message object of type '<ObstacleData>"
  "c7c5bd8b9af820dc426a86df5648338e")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ObstacleData)))
  "Returns md5sum for a message object of type 'ObstacleData"
  "c7c5bd8b9af820dc426a86df5648338e")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ObstacleData>)))
  "Returns full string definition for message of type '<ObstacleData>"
  (cl:format cl:nil "# 개별 장애물 데이터~%geometry_msgs/Point obstacle_global~%float32 ob_height~%float32 ob_width~%float32 a_ob_distance~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ObstacleData)))
  "Returns full string definition for message of type 'ObstacleData"
  (cl:format cl:nil "# 개별 장애물 데이터~%geometry_msgs/Point obstacle_global~%float32 ob_height~%float32 ob_width~%float32 a_ob_distance~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ObstacleData>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'obstacle_global))
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ObstacleData>))
  "Converts a ROS message object to a list"
  (cl:list 'ObstacleData
    (cl:cons ':obstacle_global (obstacle_global msg))
    (cl:cons ':ob_height (ob_height msg))
    (cl:cons ':ob_width (ob_width msg))
    (cl:cons ':a_ob_distance (a_ob_distance msg))
))
