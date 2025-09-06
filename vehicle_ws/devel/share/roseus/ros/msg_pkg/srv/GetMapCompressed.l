;; Auto-generated. Do not edit!


(when (boundp 'msg_pkg::GetMapCompressed)
  (if (not (find-package "MSG_PKG"))
    (make-package "MSG_PKG"))
  (shadow 'GetMapCompressed (find-package "MSG_PKG")))
(unless (find-package "MSG_PKG::GETMAPCOMPRESSED")
  (make-package "MSG_PKG::GETMAPCOMPRESSED"))
(unless (find-package "MSG_PKG::GETMAPCOMPRESSEDREQUEST")
  (make-package "MSG_PKG::GETMAPCOMPRESSEDREQUEST"))
(unless (find-package "MSG_PKG::GETMAPCOMPRESSEDRESPONSE")
  (make-package "MSG_PKG::GETMAPCOMPRESSEDRESPONSE"))

(in-package "ROS")



(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "SENSOR_MSGS"))
  (ros::roseus-add-msgs "sensor_msgs"))


(defclass msg_pkg::GetMapCompressedRequest
  :super ros::object
  :slots ())

(defmethod msg_pkg::GetMapCompressedRequest
  (:init
   (&key
    )
   (send-super :init)
   self)
  (:serialization-length
   ()
   (+
    0
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;;
   self)
  )

(defclass msg_pkg::GetMapCompressedResponse
  :super ros::object
  :slots (_success _message _image _image_points_px _map_tm_points _yaw0_unit ))

(defmethod msg_pkg::GetMapCompressedResponse
  (:init
   (&key
    ((:success __success) nil)
    ((:message __message) "")
    ((:image __image) (instance sensor_msgs::CompressedImage :init))
    ((:image_points_px __image_points_px) (let (r) (dotimes (i 4) (push (instance geometry_msgs::Point :init) r)) r))
    ((:map_tm_points __map_tm_points) (let (r) (dotimes (i 4) (push (instance geometry_msgs::Point :init) r)) r))
    ((:yaw0_unit __yaw0_unit) (instance geometry_msgs::Vector3 :init))
    )
   (send-super :init)
   (setq _success __success)
   (setq _message (string __message))
   (setq _image __image)
   (setq _image_points_px __image_points_px)
   (setq _map_tm_points __map_tm_points)
   (setq _yaw0_unit __yaw0_unit)
   self)
  (:success
   (&optional __success)
   (if __success (setq _success __success)) _success)
  (:message
   (&optional __message)
   (if __message (setq _message __message)) _message)
  (:image
   (&rest __image)
   (if (keywordp (car __image))
       (send* _image __image)
     (progn
       (if __image (setq _image (car __image)))
       _image)))
  (:image_points_px
   (&rest __image_points_px)
   (if (keywordp (car __image_points_px))
       (send* _image_points_px __image_points_px)
     (progn
       (if __image_points_px (setq _image_points_px (car __image_points_px)))
       _image_points_px)))
  (:map_tm_points
   (&rest __map_tm_points)
   (if (keywordp (car __map_tm_points))
       (send* _map_tm_points __map_tm_points)
     (progn
       (if __map_tm_points (setq _map_tm_points (car __map_tm_points)))
       _map_tm_points)))
  (:yaw0_unit
   (&rest __yaw0_unit)
   (if (keywordp (car __yaw0_unit))
       (send* _yaw0_unit __yaw0_unit)
     (progn
       (if __yaw0_unit (setq _yaw0_unit (car __yaw0_unit)))
       _yaw0_unit)))
  (:serialization-length
   ()
   (+
    ;; bool _success
    1
    ;; string _message
    4 (length _message)
    ;; sensor_msgs/CompressedImage _image
    (send _image :serialization-length)
    ;; geometry_msgs/Point[4] _image_points_px
    (apply #'+ (send-all _image_points_px :serialization-length))
    ;; geometry_msgs/Point[4] _map_tm_points
    (apply #'+ (send-all _map_tm_points :serialization-length))
    ;; geometry_msgs/Vector3 _yaw0_unit
    (send _yaw0_unit :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _success
       (if _success (write-byte -1 s) (write-byte 0 s))
     ;; string _message
       (write-long (length _message) s) (princ _message s)
     ;; sensor_msgs/CompressedImage _image
       (send _image :serialize s)
     ;; geometry_msgs/Point[4] _image_points_px
     (dolist (elem _image_points_px)
       (send elem :serialize s)
       )
     ;; geometry_msgs/Point[4] _map_tm_points
     (dolist (elem _map_tm_points)
       (send elem :serialize s)
       )
     ;; geometry_msgs/Vector3 _yaw0_unit
       (send _yaw0_unit :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _success
     (setq _success (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string _message
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _message (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; sensor_msgs/CompressedImage _image
     (send _image :deserialize buf ptr-) (incf ptr- (send _image :serialization-length))
   ;; geometry_msgs/Point[4] _image_points_px
   (dotimes (i 4)
     (send (elt _image_points_px i) :deserialize buf ptr-) (incf ptr- (send (elt _image_points_px i) :serialization-length))
     )
   ;; geometry_msgs/Point[4] _map_tm_points
   (dotimes (i 4)
     (send (elt _map_tm_points i) :deserialize buf ptr-) (incf ptr- (send (elt _map_tm_points i) :serialization-length))
     )
   ;; geometry_msgs/Vector3 _yaw0_unit
     (send _yaw0_unit :deserialize buf ptr-) (incf ptr- (send _yaw0_unit :serialization-length))
   ;;
   self)
  )

(defclass msg_pkg::GetMapCompressed
  :super ros::object
  :slots ())

(setf (get msg_pkg::GetMapCompressed :md5sum-) "54ee168365956cd5736b351118adcd18")
(setf (get msg_pkg::GetMapCompressed :datatype-) "msg_pkg/GetMapCompressed")
(setf (get msg_pkg::GetMapCompressed :request) msg_pkg::GetMapCompressedRequest)
(setf (get msg_pkg::GetMapCompressed :response) msg_pkg::GetMapCompressedResponse)

(defmethod msg_pkg::GetMapCompressedRequest
  (:response () (instance msg_pkg::GetMapCompressedResponse :init)))

(setf (get msg_pkg::GetMapCompressedRequest :md5sum-) "54ee168365956cd5736b351118adcd18")
(setf (get msg_pkg::GetMapCompressedRequest :datatype-) "msg_pkg/GetMapCompressedRequest")
(setf (get msg_pkg::GetMapCompressedRequest :definition-)
      "
---
bool success
string message
sensor_msgs/CompressedImage image
geometry_msgs/Point[4] image_points_px
geometry_msgs/Point[4] map_tm_points
geometry_msgs/Vector3 yaw0_unit


================================================================================
MSG: sensor_msgs/CompressedImage
# This message contains a compressed image

Header header        # Header timestamp should be acquisition time of image
                     # Header frame_id should be optical frame of camera
                     # origin of frame should be optical center of camera
                     # +x should point to the right in the image
                     # +y should point down in the image
                     # +z should point into to plane of the image

string format        # Specifies the format of the data
                     #   Acceptable values:
                     #     jpeg, png
uint8[] data         # Compressed image buffer

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
MSG: geometry_msgs/Vector3
# This represents a vector in free space. 
# It is only meant to represent a direction. Therefore, it does not
# make sense to apply a translation to it (e.g., when applying a 
# generic rigid transformation to a Vector3, tf2 will only apply the
# rotation). If you want your data to be translatable too, use the
# geometry_msgs/Point message instead.

float64 x
float64 y
")

(setf (get msg_pkg::GetMapCompressedResponse :md5sum-) "54ee168365956cd5736b351118adcd18")
(setf (get msg_pkg::GetMapCompressedResponse :datatype-) "msg_pkg/GetMapCompressedResponse")
(setf (get msg_pkg::GetMapCompressedResponse :definition-)
      "
---
bool success
string message
sensor_msgs/CompressedImage image
geometry_msgs/Point[4] image_points_px
geometry_msgs/Point[4] map_tm_points
geometry_msgs/Vector3 yaw0_unit


================================================================================
MSG: sensor_msgs/CompressedImage
# This message contains a compressed image

Header header        # Header timestamp should be acquisition time of image
                     # Header frame_id should be optical frame of camera
                     # origin of frame should be optical center of camera
                     # +x should point to the right in the image
                     # +y should point down in the image
                     # +z should point into to plane of the image

string format        # Specifies the format of the data
                     #   Acceptable values:
                     #     jpeg, png
uint8[] data         # Compressed image buffer

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
MSG: geometry_msgs/Vector3
# This represents a vector in free space. 
# It is only meant to represent a direction. Therefore, it does not
# make sense to apply a translation to it (e.g., when applying a 
# generic rigid transformation to a Vector3, tf2 will only apply the
# rotation). If you want your data to be translatable too, use the
# geometry_msgs/Point message instead.

float64 x
float64 y
")



(provide :msg_pkg/GetMapCompressed "54ee168365956cd5736b351118adcd18")


