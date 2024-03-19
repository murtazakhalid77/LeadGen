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

  @override
  String toString() {
    return 'LocationModel(locality: $locality, subLocality: $subLocality, street: $street, country: $country, '
        'subAdministrativeArea: $subAdministrativeArea, administrativeArea: $administrativeArea, deviceId: $deviceId)';
  }

   static LocationModel fromString(String locationString) {
    // Remove "LocationModel(" from the beginning and ")" from the end
    locationString = locationString.substring(14, locationString.length - 1);

    // Split the string by ", " to get individual key-value pairs
    List<String> keyValuePairs = locationString.split(', ');

    // Create a map to store the extracted key-value pairs
    Map<String, String?> locationMap = {};

    // Iterate over the key-value pairs and extract the key and value
    keyValuePairs.forEach((pair) {
      List<String> parts = pair.split(': ');
      String key = parts[0].trim();
      String? value = parts.length > 1 ? parts[1].trim() : null;
      locationMap[key] = value;
    });

    // Create a LocationModel instance using the extracted data
    return LocationModel(
      locality: locationMap['locality'],
      subLocality: locationMap['subLocality'],
      street: locationMap['street'],
      country: locationMap['country'],
      subAdministrativeArea: locationMap['subAdministrativeArea'],
      administrativeArea: locationMap['administrativeArea'],
      deviceId: locationMap['deviceId'],
    );
  }
}