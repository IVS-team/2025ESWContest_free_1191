// Auto-generated. Do not edit!

// (in-package msg_pkg.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let geometry_msgs = _finder('geometry_msgs');

//-----------------------------------------------------------

class ProcessedObject {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.object_id = null;
      this.relative_distance = null;
      this.risk_level = null;
      this.relative_position = null;
      this.global_position = null;
    }
    else {
      if (initObj.hasOwnProperty('object_id')) {
        this.object_id = initObj.object_id
      }
      else {
        this.object_id = 0;
      }
      if (initObj.hasOwnProperty('relative_distance')) {
        this.relative_distance = initObj.relative_distance
      }
      else {
        this.relative_distance = 0.0;
      }
      if (initObj.hasOwnProperty('risk_level')) {
        this.risk_level = initObj.risk_level
      }
      else {
        this.risk_level = 0;
      }
      if (initObj.hasOwnProperty('relative_position')) {
        this.relative_position = initObj.relative_position
      }
      else {
        this.relative_position = new geometry_msgs.msg.Point();
      }
      if (initObj.hasOwnProperty('global_position')) {
        this.global_position = initObj.global_position
      }
      else {
        this.global_position = new geometry_msgs.msg.Point();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type ProcessedObject
    // Serialize message field [object_id]
    bufferOffset = _serializer.int32(obj.object_id, buffer, bufferOffset);
    // Serialize message field [relative_distance]
    bufferOffset = _serializer.float64(obj.relative_distance, buffer, bufferOffset);
    // Serialize message field [risk_level]
    bufferOffset = _serializer.int32(obj.risk_level, buffer, bufferOffset);
    // Serialize message field [relative_position]
    bufferOffset = geometry_msgs.msg.Point.serialize(obj.relative_position, buffer, bufferOffset);
    // Serialize message field [global_position]
    bufferOffset = geometry_msgs.msg.Point.serialize(obj.global_position, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type ProcessedObject
    let len;
    let data = new ProcessedObject(null);
    // Deserialize message field [object_id]
    data.object_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [relative_distance]
    data.relative_distance = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [risk_level]
    data.risk_level = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [relative_position]
    data.relative_position = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset);
    // Deserialize message field [global_position]
    data.global_position = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 64;
  }

  static datatype() {
    // Returns string type for a message object
    return 'msg_pkg/ProcessedObject';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'a5c038ccad5ad73f55b80d3464c5fdb7';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 object_id
    float64 relative_distance
    int32 risk_level
    geometry_msgs/Point relative_position
    geometry_msgs/Point global_position
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
    const resolved = new ProcessedObject(null);
    if (msg.object_id !== undefined) {
      resolved.object_id = msg.object_id;
    }
    else {
      resolved.object_id = 0
    }

    if (msg.relative_distance !== undefined) {
      resolved.relative_distance = msg.relative_distance;
    }
    else {
      resolved.relative_distance = 0.0
    }

    if (msg.risk_level !== undefined) {
      resolved.risk_level = msg.risk_level;
    }
    else {
      resolved.risk_level = 0
    }

    if (msg.relative_position !== undefined) {
      resolved.relative_position = geometry_msgs.msg.Point.Resolve(msg.relative_position)
    }
    else {
      resolved.relative_position = new geometry_msgs.msg.Point()
    }

    if (msg.global_position !== undefined) {
      resolved.global_position = geometry_msgs.msg.Point.Resolve(msg.global_position)
    }
    else {
      resolved.global_position = new geometry_msgs.msg.Point()
    }

    return resolved;
    }
};

module.exports = ProcessedObject;
