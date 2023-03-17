class MapZone {
  String? zoneName;
  String? zoneId;
  List<ZonePoints>? zonePoints;

  MapZone({this.zoneName, this.zonePoints, this.zoneId});

  MapZone.fromJson(Map<String, dynamic> json) {
    zoneName = json['zone_name'];
    zoneId = json['zone_id'];
    if (json['zone_points'] != null) {
      zonePoints = <ZonePoints>[];
      json['zone_points'].forEach((v) {
        zonePoints!.add(ZonePoints.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['zone_name'] = zoneName;
    data['zone_id'] = zoneId;
    if (zonePoints != null) {
      data['zone_points'] = zonePoints!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ZonePoints {
  double? longitude;
  double? latitude;

  ZonePoints({this.longitude, this.latitude});

  ZonePoints.fromJson(Map<String, dynamic> json) {
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    return data;
  }
}