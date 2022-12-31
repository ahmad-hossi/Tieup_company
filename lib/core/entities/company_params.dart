class CompanyParams {
  int? cityId;
  String name;
  String description;
  String phone;
  String address;
  double? longitude;
  double? latitude;

  CompanyParams(
      {
     required   this.cityId,
     required this.name,
     required this.description,
     required this.phone,
     required this.address,
     required this.longitude,
     required this.latitude});

  Map<String, dynamic> toJson() => {
        'city_id': cityId.toString(),
        'name': name,
        'discript': description,
        'phone': phone,
        'location': address,
        'longitude': longitude.toString(),
        'latitude': latitude.toString(),
      };
}
