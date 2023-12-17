class LocationModel {
  final String? locality;
  final String? subLocality;
  final String? street;
  final String? country;
  final String? subAdministrativeArea;
  final String? administrativeArea;

  LocationModel({
    this.locality,
    this.subLocality,
    this.street,
    this.country,
    this.subAdministrativeArea,
    this.administrativeArea,
  });

  Map<String, dynamic> toJson() {
    return {
      'locality': locality,
      'subLocality': subLocality,
      'street': street,
      'country': country,
      'subAdministrativeArea': subAdministrativeArea,
      'administrativeArea': administrativeArea,
    };
  }
}