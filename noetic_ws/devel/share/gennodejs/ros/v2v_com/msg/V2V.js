// Auto-generated. Do not edit!

// (in-package v2v_com.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let ObstacleData = require('./ObstacleData.js');
let std_msgs = _finder('std_msgs');
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class V2V {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.a_global = null;
      this.a_yaw = null;
      this.obstacles = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('a_global')) {
        this.a_global = initObj.a_global
      }
      else {
        this.a_global = new geometry_msgs.msg.Point();
      }
      if (initObj.hasOwnProperty('a_yaw')) {
        this.a_yaw = initObj.a_yaw
      }
      else {
        this.a_yaw = 0.0;
      }
      if (initObj.hasOwnProperty('obstacles')) {
        this.obstacles = initObj.obstacles
      }
      else {
        this.obstacles = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type V2V
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [a_global]
    bufferOffset = geometry_msgs.msg.Point.serialize(obj.a_global, buffer, bufferOffset);
    // Serialize message field [a_yaw]
    bufferOffset = _serializer.float32(obj.a_yaw, buffer, bufferOffset);
    // Serialize message field [obstacles]
    // Serialize the length for message field [obstacles]
    bufferOffset = _serializer.uint32(obj.obstacles.length, buffer, bufferOffset);
    obj.obstacles.forEach((val) => {
      bufferOffset = ObstacleData.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type V2V
    let len;
    let data = new V2V(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [a_global]
    data.a_global = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset);
    // Deserialize message field [a_yaw]
    data.a_yaw = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [obstacles]
    // Deserialize array length for message field [obstacles]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.obstacles = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.obstacles[i] = ObstacleData.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 36 * object.obstacles.length;
    return length + 32;
  }

  static datatype() {
    // Returns string type for a message object
    return 'v2v_com/V2V';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '100a5c98016f608ae0d405a275ce49f4';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    # 종합 데이터
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
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new V2V(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.a_global !== undefined) {
      resolved.a_global = geometry_msgs.msg.Point.Resolve(msg.a_global)
    }
    else {
      resolved.a_global = new geometry_msgs.msg.Point()
    }

    if (msg.a_yaw !== undefined) {
      resolved.a_yaw = msg.a_yaw;
    }
    else {
      resolved.a_yaw = 0.0
    }

    if (msg.obstacles !== undefined) {
      resolved.obstacles = new Array(msg.obstacles.length);
      for (let i = 0; i < resolved.obstacles.length; ++i) {
        resolved.obstacles[i] = ObstacleData.Resolve(msg.obstacles[i]);
      }
    }
    else {
      resolved.obstacles = []
    }

    return resolved;
    }
};

module.exports = V2V;
