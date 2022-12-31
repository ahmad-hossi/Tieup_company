class Profile {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String? description;
  final String? address;
  final int? cityId;
  final String? cityName;
  final String? imageUrl;
  final String? coverImageUrl;
  final double? longitude;
  final double? latitude;

  Profile(
      {required this.id,
      required this.name,
      required this.phone,
      required this.email,
      this.description,
      this.address,
      this.cityId,
      this.cityName,
      this.imageUrl,
      this.coverImageUrl,
      this.longitude,
      this.latitude});
}
