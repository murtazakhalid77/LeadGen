class LocationModel {
  final String? locality;
  final String? subLocality;
  final String? street;
  final String? country;
  final String? subAdministrativeArea;
  final String? administrativeArea;
  final String? deviceId;

  LocationModel({
    this.locality,
    this.subLocality,
    this.street,
    this.country,
    this.subAdministrativeArea,
    this.administrativeArea,
    this.deviceId
  });

  Map<String, dynamic> toJson() {
    return {
      'locality': locality,
      'subLocality': subLocality,
      'street': street,
      'country': country,
      'subAdministrativeArea': subAdministrativeArea,
      'administrativeArea': administrativeArea,
      'deviceId':deviceId
    };
  }
    factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      locality: json['locality'] as String?,
      subLocality: json['subLocality'] as String?,
      street: json['street'] as String?,
      country: json['country'] as String?,
      subAdministrativeArea: json['subAdministrativeArea'] as String?,
      administrativeArea: json['administrativeArea'] as String?,
      deviceId: json['deviceId'] as String?
    );
  }

}