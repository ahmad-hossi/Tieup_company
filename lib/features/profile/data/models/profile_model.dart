import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/profile.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel extends Profile {
  final int id;
  final String name;
  final String phone;
  final String email;
  final String? description;
  @JsonKey(name: 'location')
  final String? address;
  @JsonKey(name: 'city_id')
  final int? cityId;
  @JsonKey(name: 'city')
  final String? cityName;
  @JsonKey(name: 'profile_image')
  final String? imageUrl;
  @JsonKey(name: 'cover_image')
  final String? coverImageUrl;
  final double? longitude;
  final double? latitude;

  ProfileModel(
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
      this.latitude})
      : super(
            id: id,
            name: name,
            email: email,
            phone: phone,
            imageUrl: imageUrl,
            cityId: cityId,
            description: description,
            latitude: latitude,
            longitude: longitude,
            coverImageUrl: coverImageUrl,
            address: address,
            cityName: cityName);

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);
}
