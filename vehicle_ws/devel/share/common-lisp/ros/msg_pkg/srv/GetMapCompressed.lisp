; Auto-generated. Do not edit!


(cl:in-package msg_pkg-srv)


;//! \htmlinclude GetMapCompressed-request.msg.html

(cl:defclass <GetMapCompressed-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass GetMapCompressed-request (<GetMapCompressed-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetMapCompressed-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetMapCompressed-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name msg_pkg-srv:<GetMapCompressed-request> is deprecated: use msg_pkg-srv:GetMapCompressed-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetMapCompressed-request>) ostream)
  "Serializes a message object of type '<GetMapCompressed-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetMapCompressed-request>) istream)
  "Deserializes a message object of type '<GetMapCompressed-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetMapCompressed-request>)))
  "Returns string type for a service object of type '<GetMapCompressed-request>"
  "msg_pkg/GetMapCompressedRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetMapCompressed-request)))
  "Returns string type for a service object of type 'GetMapCompressed-request"
  "msg_pkg/GetMapCompressedRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetMapCompressed-request>)))
  "Returns md5sum for a message object of type '<GetMapCompressed-request>"
  "54ee168365956cd5736b351118adcd18")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetMapCompressed-request)))
  "Returns md5sum for a message object of type 'GetMapCompressed-request"
  "54ee168365956cd5736b351118adcd18")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetMapCompressed-request>)))
  "Returns full string definition for message of type '<GetMapCompressed-request>"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetMapCompressed-request)))
  "Returns full string definition for message of type 'GetMapCompressed-request"
  (cl:format cl:nil "~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetMapCompressed-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetMapCompressed-request>))
  "Converts a ROS message object to a list"
  (cl:list 'GetMapCompressed-request
))
;//! \htmlinclude GetMapCompressed-response.msg.html

(cl:defclass <GetMapCompressed-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil)
   (message
    :reader message
    :initarg :message
    :type cl:string
    :initform "")
   (image
    :reader image
    :initarg :image
    :type sensor_msgs-msg:CompressedImage
    :initform (cl:make-instance 'sensor_msgs-msg:CompressedImage))
   (image_points_px
    :reader image_points_px
    :initarg :image_points_px
    :type (cl:vector geometry_msgs-msg:Point)
   :initform (cl:make-array 4 :element-type 'geometry_msgs-msg:Point :initial-element (cl:make-instance 'geometry_msgs-msg:Point)))
   (map_tm_points
    :reader map_tm_points
    :initarg :map_tm_points
    :type (cl:vector geometry_msgs-msg:Point)
   :initform (cl:make-array 4 :element-type 'geometry_msgs-msg:Point :initial-element (cl:make-instance 'geometry_msgs-msg:Point)))
   (yaw0_unit
    :reader yaw0_unit
    :initarg :yaw0_unit
    :type geometry_msgs-msg:Vector3
    :initform (cl:make-instance 'geometry_msgs-msg:Vector3)))
)

(cl:defclass GetMapCompressed-response (<GetMapCompressed-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <GetMapCompressed-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'GetMapCompressed-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name msg_pkg-srv:<GetMapCompressed-response> is deprecated: use msg_pkg-srv:GetMapCompressed-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <GetMapCompressed-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader msg_pkg-srv:success-val is deprecated.  Use msg_pkg-srv:success instead.")
  (success m))

(cl:ensure-generic-function 'message-val :lambda-list '(m))
(cl:defmethod message-val ((m <GetMapCompressed-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader msg_pkg-srv:message-val is deprecated.  Use msg_pkg-srv:message instead.")
  (message m))

(cl:ensure-generic-function 'image-val :lambda-list '(m))
(cl:defmethod image-val ((m <GetMapCompressed-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader msg_pkg-srv:image-val is deprecated.  Use msg_pkg-srv:image instead.")
  (image m))

(cl:ensure-generic-function 'image_points_px-val :lambda-list '(m))
(cl:defmethod image_points_px-val ((m <GetMapCompressed-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader msg_pkg-srv:image_points_px-val is deprecated.  Use msg_pkg-srv:image_points_px instead.")
  (image_points_px m))

(cl:ensure-generic-function 'map_tm_points-val :lambda-list '(m))
(cl:defmethod map_tm_points-val ((m <GetMapCompressed-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader msg_pkg-srv:map_tm_points-val is deprecated.  Use msg_pkg-srv:map_tm_points instead.")
  (map_tm_points m))

(cl:ensure-generic-function 'yaw0_unit-val :lambda-list '(m))
(cl:defmethod yaw0_unit-val ((m <GetMapCompressed-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader msg_pkg-srv:yaw0_unit-val is deprecated.  Use msg_pkg-srv:yaw0_unit instead.")
  (yaw0_unit m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <GetMapCompressed-response>) ostream)
  "Serializes a message object of type '<GetMapCompressed-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'message))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'message))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'image) ostream)
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'image_points_px))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'map_tm_points))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'yaw0_unit) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <GetMapCompressed-response>) istream)
  "Deserializes a message object of type '<GetMapCompressed-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'message) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'message) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'image) istream)
  (cl:setf (cl:slot-value msg 'image_points_px) (cl:make-array 4))
  (cl:let ((vals (cl:slot-value msg 'image_points_px)))
    (cl:dotimes (i 4)
    (cl:setf (cl:aref vals i) (cl:make-instance 'geometry_msgs-msg:Point))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream)))
  (cl:setf (cl:slot-value msg 'map_tm_points) (cl:make-array 4))
  (cl:let ((vals (cl:slot-value msg 'map_tm_points)))
    (cl:dotimes (i 4)
    (cl:setf (cl:aref vals i) (cl:make-instance 'geometry_msgs-msg:Point))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream)))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'yaw0_unit) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<GetMapCompressed-response>)))
  "Returns string type for a service object of type '<GetMapCompressed-response>"
  "msg_pkg/GetMapCompressedResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetMapCompressed-response)))
  "Returns string type for a service object of type 'GetMapCompressed-response"
  "msg_pkg/GetMapCompressedResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<GetMapCompressed-response>)))
  "Returns md5sum for a message object of type '<GetMapCompressed-response>"
  "54ee168365956cd5736b351118adcd18")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'GetMapCompressed-response)))
  "Returns md5sum for a message object of type 'GetMapCompressed-response"
  "54ee168365956cd5736b351118adcd18")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<GetMapCompressed-response>)))
  "Returns full string definition for message of type '<GetMapCompressed-response>"
  (cl:format cl:nil "bool success~%string message~%sensor_msgs/CompressedImage image~%geometry_msgs/Point[4] image_points_px~%geometry_msgs/Point[4] map_tm_points~%geometry_msgs/Vector3 yaw0_unit~%~%~%================================================================================~%MSG: sensor_msgs/CompressedImage~%# This message contains a compressed image~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of camera~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%~%string format        # Specifies the format of the data~%                     #   Acceptable values:~%                     #     jpeg, png~%uint8[] data         # Compressed image buffer~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'GetMapCompressed-response)))
  "Returns full string definition for message of type 'GetMapCompressed-response"
  (cl:format cl:nil "bool success~%string message~%sensor_msgs/CompressedImage image~%geometry_msgs/Point[4] image_points_px~%geometry_msgs/Point[4] map_tm_points~%geometry_msgs/Vector3 yaw0_unit~%~%~%================================================================================~%MSG: sensor_msgs/CompressedImage~%# This message contains a compressed image~%~%Header header        # Header timestamp should be acquisition time of image~%                     # Header frame_id should be optical frame of camera~%                     # origin of frame should be optical center of camera~%                     # +x should point to the right in the image~%                     # +y should point down in the image~%                     # +z should point into to plane of the image~%~%string format        # Specifies the format of the data~%                     #   Acceptable values:~%                     #     jpeg, png~%uint8[] data         # Compressed image buffer~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <GetMapCompressed-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'message))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'image))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'image_points_px) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     0 (cl:reduce #'cl:+ (cl:slot-value msg 'map_tm_points) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'yaw0_unit))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <GetMapCompressed-response>))
  "Converts a ROS message object to a list"
  (cl:list 'GetMapCompressed-response
    (cl:cons ':success (success msg))
    (cl:cons ':message (message msg))
    (cl:cons ':image (image msg))
    (cl:cons ':image_points_px (image_points_px msg))
    (cl:cons ':map_tm_points (map_tm_points msg))
    (cl:cons ':yaw0_unit (yaw0_unit msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'GetMapCompressed)))
  'GetMapCompressed-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'GetMapCompressed)))
  'GetMapCompressed-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'GetMapCompressed)))
  "Returns string type for a service object of type '<GetMapCompressed>"
  "msg_pkg/GetMapCompressed")