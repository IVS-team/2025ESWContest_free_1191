// Auto-generated. Do not edit!

// (in-package msg_pkg.srv)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

let geometry_msgs = _finder('geometry_msgs');
let sensor_msgs = _finder('sensor_msgs');

//-----------------------------------------------------------

class GetMapCompressedRequest {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
    }
    else {
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GetMapCompressedRequest
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GetMapCompressedRequest
    let len;
    let data = new GetMapCompressedRequest(null);
    return data;
  }

  static getMessageSize(object) {
    return 0;
  }

  static datatype() {
    // Returns string type for a service object
    return 'msg_pkg/GetMapCompressedRequest';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd41d8cd98f00b204e9800998ecf8427e';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new GetMapCompressedRequest(null);
    return resolved;
    }
};

class GetMapCompressedResponse {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.success = null;
      this.message = null;
      this.image = null;
      this.image_points_px = null;
      this.map_tm_points = null;
      this.yaw0_unit = null;
    }
    else {
      if (initObj.hasOwnProperty('success')) {
        this.success = initObj.success
      }
      else {
        this.success = false;
      }
      if (initObj.hasOwnProperty('message')) {
        this.message = initObj.message
      }
      else {
        this.message = '';
      }
      if (initObj.hasOwnProperty('image')) {
        this.image = initObj.image
      }
      else {
        this.image = new sensor_msgs.msg.CompressedImage();
      }
      if (initObj.hasOwnProperty('image_points_px')) {
        this.image_points_px = initObj.image_points_px
      }
      else {
        this.image_points_px = new Array(4).fill(new geometry_msgs.msg.Point());
      }
      if (initObj.hasOwnProperty('map_tm_points')) {
        this.map_tm_points = initObj.map_tm_points
      }
      else {
        this.map_tm_points = new Array(4).fill(new geometry_msgs.msg.Point());
      }
      if (initObj.hasOwnProperty('yaw0_unit')) {
        this.yaw0_unit = initObj.yaw0_unit
      }
      else {
        this.yaw0_unit = new geometry_msgs.msg.Vector3();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type GetMapCompressedResponse
    // Serialize message field [success]
    bufferOffset = _serializer.bool(obj.success, buffer, bufferOffset);
    // Serialize message field [message]
    bufferOffset = _serializer.string(obj.message, buffer, bufferOffset);
    // Serialize message field [image]
    bufferOffset = sensor_msgs.msg.CompressedImage.serialize(obj.image, buffer, bufferOffset);
    // Check that the constant length array field [image_points_px] has the right length
    if (obj.image_points_px.length !== 4) {
      throw new Error('Unable to serialize array field image_points_px - length must be 4')
    }
    // Serialize message field [image_points_px]
    obj.image_points_px.forEach((val) => {
      bufferOffset = geometry_msgs.msg.Point.serialize(val, buffer, bufferOffset);
    });
    // Check that the constant length array field [map_tm_points] has the right length
    if (obj.map_tm_points.length !== 4) {
      throw new Error('Unable to serialize array field map_tm_points - length must be 4')
    }
    // Serialize message field [map_tm_points]
    obj.map_tm_points.forEach((val) => {
      bufferOffset = geometry_msgs.msg.Point.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [yaw0_unit]
    bufferOffset = geometry_msgs.msg.Vector3.serialize(obj.yaw0_unit, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type GetMapCompressedResponse
    let len;
    let data = new GetMapCompressedResponse(null);
    // Deserialize message field [success]
    data.success = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [message]
    data.message = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [image]
    data.image = sensor_msgs.msg.CompressedImage.deserialize(buffer, bufferOffset);
    // Deserialize message field [image_points_px]
    len = 4;
    data.image_points_px = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.image_points_px[i] = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [map_tm_points]
    len = 4;
    data.map_tm_points = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.map_tm_points[i] = geometry_msgs.msg.Point.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [yaw0_unit]
    data.yaw0_unit = geometry_msgs.msg.Vector3.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += object.message.length;
    length += sensor_msgs.msg.CompressedImage.getMessageSize(object.image);
    return length + 221;
  }

  static datatype() {
    // Returns string type for a service object
    return 'msg_pkg/GetMapCompressedResponse';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '54ee168365956cd5736b351118adcd18';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
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
    float64 z
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new GetMapCompressedResponse(null);
    if (msg.success !== undefined) {
      resolved.success = msg.success;
    }
    else {
      resolved.success = false
    }

    if (msg.message !== undefined) {
      resolved.message = msg.message;
    }
    else {
      resolved.message = ''
    }

    if (msg.image !== undefined) {
      resolved.image = sensor_msgs.msg.CompressedImage.Resolve(msg.image)
    }
    else {
      resolved.image = new sensor_msgs.msg.CompressedImage()
    }

    if (msg.image_points_px !== undefined) {
      resolved.image_points_px = new Array(4)
      for (let i = 0; i < resolved.image_points_px.length; ++i) {
        if (msg.image_points_px.length > i) {
          resolved.image_points_px[i] = geometry_msgs.msg.Point.Resolve(msg.image_points_px[i]);
        }
        else {
          resolved.image_points_px[i] = new geometry_msgs.msg.Point();
        }
      }
    }
    else {
      resolved.image_points_px = new Array(4).fill(new geometry_msgs.msg.Point())
    }

    if (msg.map_tm_points !== undefined) {
      resolved.map_tm_points = new Array(4)
      for (let i = 0; i < resolved.map_tm_points.length; ++i) {
        if (msg.map_tm_points.length > i) {
          resolved.map_tm_points[i] = geometry_msgs.msg.Point.Resolve(msg.map_tm_points[i]);
        }
        else {
          resolved.map_tm_points[i] = new geometry_msgs.msg.Point();
        }
      }
    }
    else {
      resolved.map_tm_points = new Array(4).fill(new geometry_msgs.msg.Point())
    }

    if (msg.yaw0_unit !== undefined) {
      resolved.yaw0_unit = geometry_msgs.msg.Vector3.Resolve(msg.yaw0_unit)
    }
    else {
      resolved.yaw0_unit = new geometry_msgs.msg.Vector3()
    }

    return resolved;
    }
};

module.exports = {
  Request: GetMapCompressedRequest,
  Response: GetMapCompressedResponse,
  md5sum() { return '54ee168365956cd5736b351118adcd18'; },
  datatype() { return 'msg_pkg/GetMapCompressed'; }
};
