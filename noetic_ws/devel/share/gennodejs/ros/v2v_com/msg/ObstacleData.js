// Auto-generated. Do not edit!

// (in-package v2v_com.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class ObstacleData {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.obstacle_global = null;
      this.ob_height = null;
      this.ob_width = null;
      this.a_ob_distance = null;
    }
    else {
      if (initObj.hasOwnProperty('obstacle_global')) {
        this.obstacle_global = initObj.obstacle_global
      }
      else {
        this.obstacle_global = new geometry_msgs.msg.Point();
      }
      if (initObj.hasOwnProperty('ob_height')) {
        this.ob_height = initObj.ob_height
      }
      else {
        this.ob_height = 0.0;
      }
      if (initObj.hasOwnProperty('ob_width')) {
        this.ob_width = initObj.ob_width
      }
      else {
        this.ob_width = 0.0;
      }
      if (initObj.hasOwnProperty('a_ob_distance')) {
        this.a_ob_distance = initObj.a_ob_distance
      }
      else {
        this.a_ob_distance = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ObstacleData
    // Serialize message field [obstacle_global]
    bufferOffset = geometry_msgs.msg.Point.serialize(obj.obstacle_global, buffer, bufferOffset);
    // Serialize message field [ob_height]
    bufferOffset = _serializer.float32(obj.ob_height, buffer, bufferOffset);
    // Serialize message field [ob_width]
    bufferOffset = _serializer.float32(obj.ob_width, buffer, bufferOffset);
    // Serialize message field [a_ob_distance]
    bufferOffset = _serializer.float32(obj.a_ob_distance, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ObstacleData
    let len;
    let data = new ObstacleData(null);
    // Deserialize message field [obstacle_global]
    data.obstacle_global = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset);
    // Deserialize message field [ob_height]
    data.ob_height = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [ob_width]
    data.ob_width = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [a_ob_distance]
    data.a_ob_distance = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 36;
  }

  static datatype() {
    // Returns string type for a message object
    return 'v2v_com/ObstacleData';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'c7c5bd8b9af820dc426a86df5648338e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # 개별 장애물 데이터
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
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ObstacleData(null);
    if (msg.obstacle_global !== undefined) {
      resolved.obstacle_global = geometry_msgs.msg.Point.Resolve(msg.obstacle_global)
    }
    else {
      resolved.obstacle_global = new geometry_msgs.msg.Point()
    }

    if (msg.ob_height !== undefined) {
      resolved.ob_height = msg.ob_height;
    }
    else {
      resolved.ob_height = 0.0
    }

    if (msg.ob_width !== undefined) {
      resolved.ob_width = msg.ob_width;
    }
    else {
      resolved.ob_width = 0.0
    }

    if (msg.a_ob_distance !== undefined) {
      resolved.a_ob_distance = msg.a_ob_distance;
    }
    else {
      resolved.a_ob_distance = 0.0
    }

    return resolved;
    }
};

module.exports = ObstacleData;
