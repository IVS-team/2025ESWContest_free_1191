#include "topview_srv.h"

namespace{

  // 문자열 소문자 변환
  static std::string toLower(std::string s){
    std::transform(s.begin(), s.end(), s.begin(),
                    [](unsigned char c){ return std::tolower(c); });
    return s;
  }

  // 이미지 포맷 문자열 → 확장자
  static std::string extFromFormat(const std::string& fmt_raw){
    const std::string f = toLower(fmt_raw);
    if (f.find("png")  != std::string::npos) return "png";
    if (f.find("jpeg") != std::string::npos) return "jpg";
    if (f.find("jpg")  != std::string::npos) return "jpg";
    return "bin";
  }

}

bool call_and_save_topview_map(ros::NodeHandle& nh)
{  
  msg_pkg::GetMapCompressed srv;

  const auto& cim = srv.response.image;               // 압축 이미지
  const auto& px  = srv.response.image_points_px;     // 픽셀 4점
  const auto& tm  = srv.response.map_tm_points;       // TM 4점
  const auto& u   = srv.response.yaw0_unit;           // 단위벡터(ux,uy)

  // /infra_node/get_map_png 서비스 호출
  ros::ServiceClient client =
      nh.serviceClient<msg_pkg::GetMapCompressed>("/infra_node/get_map_png");

  ROS_INFO("Waiting for /infra_node/get_map_png ...");
  if (!client.waitForExistence(ros::Duration(5.0))) {
    ROS_ERROR("service not available");
    return false;
  }

  if (!client.call(srv) || !srv.response.success) {
    ROS_ERROR("service call failed: %s", srv.response.message.c_str());
    return false;
  }
  if (cim.data.empty()) {
    ROS_ERROR("empty image payload");
    return false;
  }



  // 압축 맵 이미지를 config/topview_map.* 로 저장
  const std::string pkg_path = ros::package::getPath("data_processing");
  std::string ws_path = pkg_path;

  const std::string needle = "/src/";
  size_t pos = ws_path.rfind(needle);
  if (pos != std::string::npos) {
    ws_path = ws_path.substr(0, pos);
  }

  const std::string base = ws_path + "/config/";

  struct stat st;
  if (stat(base.c_str(), &st) != 0) {
    ::mkdir(base.c_str(), 0755);
  }

  const std::string ext  = extFromFormat(cim.format);
  const std::string img_path  = base + "topview_map." + ext;
  const std::string json_path = base + "topview_config.json";

  std::ofstream img_ofs(img_path, std::ios::binary);
  if (!img_ofs.is_open()) {
    ROS_ERROR("failed to open image file for write: %s", img_path.c_str());
    return false;
  }

  img_ofs.write(reinterpret_cast<const char*>(cim.data.data()), cim.data.size());
  img_ofs.close();
  ROS_INFO("saved compressed map: %s (format=%s, %zu bytes)",
           img_path.c_str(), cim.format.c_str(), cim.data.size());

  // 맵 정보를 JSON으로 저장
  std::ofstream ofs(json_path);
  if (!ofs.is_open()) {
    ROS_ERROR("failed to open json file for write: %s", json_path.c_str());
    return false;
  }

  ofs << std::fixed << std::setprecision(6);
  ofs << "{\n";
  ofs << "  \"map_image_path\": \"" << img_path << "\",\n";
  ofs << "  \"image_points_px\": [["
      << px[0].x << "," << px[0].y << "], ["
      << px[1].x << "," << px[1].y << "], ["
      << px[2].x << "," << px[2].y << "], ["
      << px[3].x << "," << px[3].y << "]],\n";
  ofs << "  \"vehicle_points_tm\": [["
      << tm[0].x << "," << tm[0].y << "], ["
      << tm[1].x << "," << tm[1].y << "], ["
      << tm[2].x << "," << tm[2].y << "], ["
      << tm[3].x << "," << tm[3].y << "]],\n";
  ofs << "  \"yaw0_unit\": [" << u.x << ", " << u.y << "]\n";
  ofs << "}\n";
  ofs.close();

  ROS_INFO("saved config: %s", json_path.c_str());

  return true;
}
