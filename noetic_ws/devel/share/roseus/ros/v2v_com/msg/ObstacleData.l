;; Auto-generated. Do not edit!


(when (boundp 'v2v_com::ObstacleData)
  (if (not (find-package "V2V_COM"))
    (make-package "V2V_COM"))
  (shadow 'ObstacleData (find-package "V2V_COM")))
(unless (find-package "V2V_COM::OBSTACLEDATA")
  (make-package "V2V_COM::OBSTACLEDATA"))

(in-package "ROS")
;;//! \htmlinclude ObstacleData.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass v2v_com::ObstacleData
  :super ros::object
  :slots (_obstacle_global _ob_height _ob_width _a_ob_distance ))

(defmethod v2v_com::ObstacleData
  (:init
   (&key
    ((:obstacle_global __obstacle_global) (instance geometry_msgs::Point :init))
    ((:ob_height __ob_height) 0.0)
    ((:ob_width __ob_width) 0.0)
    ((:a_ob_distance __a_ob_distance) 0.0)
    )
   (send-super :init)
   (setq _obstacle_global __obstacle_global)
   (setq _ob_height (float __ob_height))
   (setq _ob_width (float __ob_width))
   (setq _a_ob_distance (float __a_ob_distance))
   self)
  (:obstacle_global
   (&rest __obstacle_global)
   (if (keywordp (car __obstacle_global))
       (send* _obstacle_global __obstacle_global)
     (progn
       (if __obstacle_global (setq _obstacle_global (car __obstacle_global)))
       _obstacle_global)))
  (:ob_height
   (&optional __ob_height)
   (if __ob_height (setq _ob_height __ob_height)) _ob_height)
  (:ob_width
   (&optional __ob_width)
   (if __ob_width (setq _ob_width __ob_width)) _ob_width)
  (:a_ob_distance
   (&optional __a_ob_distance)
   (if __a_ob_distance (setq _a_ob_distance __a_ob_distance)) _a_ob_distance)
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/Point _obstacle_global
    (send _obstacle_global :serialization-length)
    ;; float32 _ob_height
    4
    ;; float32 _ob_width
    4
    ;; float32 _a_ob_distance
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/Point _obstacle_global
       (send _obstacle_global :serialize s)
     ;; float32 _ob_height
       (sys::poke _ob_height (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _ob_width
       (sys::poke _ob_width (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _a_ob_distance
       (sys::poke _a_ob_distance (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/Point _obstacle_global
     (send _obstacle_global :deserialize buf ptr-) (incf ptr- (send _obstacle_global :serialization-length))
   ;; float32 _ob_height
     (setq _ob_height (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _ob_width
     (setq _ob_width (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _a_ob_distance
     (setq _a_ob_distance (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get v2v_com::ObstacleData :md5sum-) "c7c5bd8b9af820dc426a86df5648338e")
(setf (get v2v_com::ObstacleData :datatype-) "v2v_com/ObstacleData")
(setf (get v2v_com::ObstacleData :definition-)
      "# 개별 장애물 데이터
geometry_msgs/Point obstacle_global
float32 ob_height
float32 ob_width
float32 a_ob_distance
================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

")



(provide :v2v_com/ObstacleData "c7c5bd8b9af820dc426a86df5648338e")


