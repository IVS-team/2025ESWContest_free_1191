#!/usr/bin/env python
# -*- coding: utf-8 -*-
import json
import io # Python 2/3 호환성을 위해 io 모듈 임포트
import numpy as np
import cv2

class HomographyMapper:
    """
    픽셀(u,v) <-> 지면 절대좌표(X,Y) 변환기
    """

    def __init__(self, image_points, vehicle_points):
        self.image_points = self._as_float32_points(image_points, name="image_points")
        self.vehicle_points = self._as_float32_points(vehicle_points, name="vehicle_points")
        self._compute_h()

    @classmethod
    def from_json_file(cls, path):
        """
        JSON 파일을 읽어 클래스 인스턴스를 생성합니다.
        """
        # Python 2/3 호환성을 위해 io.open 사용
        with io.open(path, "r", encoding="utf-8") as f:
            cfg = json.load(f)
        return cls.from_dict(cfg)

    @classmethod
    def from_dict(cls, cfg):
        ip = cfg["image_points"]
        vp = cfg["vehicle_points"]
        return cls(ip, vp)

    def px_to_ground_abs(self, px):
        p = np.array([[[px[0], px[1]]]], dtype=np.float32)
        g = cv2.perspectiveTransform(p, self.H)[0, 0]
        return float(g[0]), float(g[1])

    def ground_to_px_abs(self, ground_xy):
        g = np.array([[[ground_xy[0], ground_xy[1]]]], dtype=np.float32)
        p = cv2.perspectiveTransform(g, self.H_inv)[0, 0]
        #return float(p[0]), float(p[1])
        return float(p[0]), float(p[1])

    def update_points(self, image_points, vehicle_points):
        self.image_points = self._as_float32_points(image_points, name="image_points")
        self.vehicle_points = self._as_float32_points(vehicle_points, name="vehicle_points")
        self._compute_h()

    def _compute_h(self):
        H, _ = cv2.findHomography(self.image_points, self.vehicle_points)
        if H is None:
            raise RuntimeError("Homography 계산 실패: 대응점 4쌍을 확인하세요!")
        self.H = H.astype(np.float32)
        self.H_inv = np.linalg.inv(self.H).astype(np.float32)

    @staticmethod
    def _as_float32_points(points, name):
        arr = np.asarray(points, dtype=np.float32)
        if arr.shape != (4, 2):
            raise ValueError("{}는 shape (4,2) 여야 합니다. 실제: {}".format(name, arr.shape))
        return arr
