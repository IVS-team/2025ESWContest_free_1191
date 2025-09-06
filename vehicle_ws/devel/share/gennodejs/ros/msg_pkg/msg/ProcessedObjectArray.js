// Auto-generated. Do not edit!

// (in-package msg_pkg.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let ProcessedObject = require('./ProcessedObject.js');
let geometry_msgs = _finder('geometry_msgs');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class ProcessedObjectArray {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.vehicle_position = null;
      this.vehicle_yaw = null;
      this.objects = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('vehicle_position')) {
        this.vehicle_position = initObj.vehicle_position
      }
      else {
        this.vehicle_position = new geometry_msgs.msg.Point();
      }
      if (initObj.hasOwnProperty('vehicle_yaw')) {
        this.vehicle_yaw = initObj.vehicle_yaw
      }
      else {
        this.vehicle_yaw = 0.0;
      }
      if (initObj.hasOwnProperty('objects')) {
        this.objects = initObj.objects
      }
      else {
        this.objects = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ProcessedObjectArray
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [vehicle_position]
    bufferOffset = geometry_msgs.msg.Point.serialize(obj.vehicle_position, buffer, bufferOffset);
    // Serialize message field [vehicle_yaw]
    bufferOffset = _serializer.float64(obj.vehicle_yaw, buffer, bufferOffset);
    // Serialize message field [objects]
    // Serialize the length for message field [objects]
    bufferOffset = _serializer.uint32(obj.objects.length, buffer, bufferOffset);
    obj.objects.forEach((val) => {
      bufferOffset = ProcessedObject.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ProcessedObjectArray
    let len;
    let data = new ProcessedObjectArray(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [vehicle_position]
    data.vehicle_position = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset);
    // Deserialize message field [vehicle_yaw]
    data.vehicle_yaw = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [objects]
    // Deserialize array length for message field [objects]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.objects = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.objects[i] = ProcessedObject.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    length += 64 * object.objects.length;
    return length + 36;
  }

  static datatype() {
    // Returns string type for a message object
    return 'msg_pkg/ProcessedObjectArray';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '2878e3c099337b128953ff448b2966e0';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    std_msgs/Header header
    geometry_msgs/Point vehicle_position
    float64 vehicle_yaw
    ProcessedObject[] objects
    
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
    MSG: msg_pkg/ProcessedObject
    int32 object_id
    float64 relative_distance
    int32 risk_level
    geometry_msgs/Point relative_position
    geometry_msgs/Point global_position
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new ProcessedObjectArray(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.vehicle_position !== undefined) {
      resolved.vehicle_position = geometry_msgs.msg.Point.Resolve(msg.vehicle_position)
    }
    else {
      resolved.vehicle_position = new geometry_msgs.msg.Point()
    }

    if (msg.vehicle_yaw !== undefined) {
      resolved.vehicle_yaw = msg.vehicle_yaw;
    }
    else {
      resolved.vehicle_yaw = 0.0
    }

    if (msg.objects !== undefined) {
      resolved.objects = new Array(msg.objects.length);
      for (let i = 0; i < resolved.objects.length; ++i) {
        resolved.objects[i] = ProcessedObject.Resolve(msg.objects[i]);
      }
    }
    else {
      resolved.objects = []
    }

    return resolved;
    }
};

module.exports = ProcessedObjectArray;
