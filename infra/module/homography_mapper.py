# homography_mapper.py (origin 없이 절대좌표 전용 버전)
import json
from typing import Iterable, Tuple, Dict, Any
import numpy as np
import cv2

ArrayLike2 = Iterable[Iterable[float]]
Point = Tuple[float, float]

class HomographyMapper:
    def __init__(self, image_points: ArrayLike2, vehicle_points: ArrayLike2) -> None:
        self.image_points = self._as_float32_points(image_points, name="image_points")
        self.vehicle_points = self._as_float32_points(vehicle_points, name="vehicle_points")
        self._compute_h()

    # ---------- public API ----------

    @classmethod
    def from_json_file(cls, path: str) -> "HomographyMapper":
        with open(path, "r", encoding="utf-8") as f:
            cfg = json.load(f)
        return cls.from_dict(cfg)

    @classmethod
    def from_dict(cls, cfg: Dict[str, Any]) -> "HomographyMapper":
        ip = cfg["image_points"]
        vp = cfg["vehicle_points"]
        return cls(ip, vp)

    def px_to_ground_abs(self, px: Point) -> Point:
        p = np.array([[[px[0], px[1]]]], dtype=np.float32)  # (1,1,2)
        g = cv2.perspectiveTransform(p, self.H)[0, 0]
        return float(g[0]), float(g[1])

    def ground_to_px_abs(self, ground_xy: Point) -> Point:
        g = np.array([[[ground_xy[0], ground_xy[1]]]], dtype=np.float32)
        p = cv2.perspectiveTransform(g, self.H_inv)[0, 0]
        return float(p[0]), float(p[1])

    def update_points(self, image_points: ArrayLike2, vehicle_points: ArrayLike2) -> None:
        self.image_points = self._as_float32_points(image_points, name="image_points")
        self.vehicle_points = self._as_float32_points(vehicle_points, name="vehicle_points")
        self._compute_h()

    # ---------- internal ----------

    def _compute_h(self) -> None:
        H, _ = cv2.findHomography(self.image_points, self.vehicle_points)
        if H is None:
            raise RuntimeError("Homography 계산 실패: 대응점 4쌍을 확인하세요!")
        self.H = H.astype(np.float32)
        self.H_inv = np.linalg.inv(self.H).astype(np.float32)

    @staticmethod
    def _as_float32_points(points: ArrayLike2, name: str) -> np.ndarray:
        arr = np.asarray(points, dtype=np.float32)
        if arr.shape != (4, 2):
            raise ValueError(f"{name}는 shape (4,2) 여야 합니다. 실제: {arr.shape}")
        return arr
