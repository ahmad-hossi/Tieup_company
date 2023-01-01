// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) {
  return ProfileModel(
    id: json['id'] as int,
    name: json['name'] as String,
    phone: json['phone'] as String,
    email: json['email'] as String,
    description: json['description'] as String?,
    address: json['location'] as String?,
    cityId: json['city_id'] as int?,
    cityName: json['city'] as String?,
    imageUrl: json['profile_image'] as String?,
    coverImageUrl: json['cover_image'] as String?,
    longitude: (json['longitude'] as num?)?.toDouble(),
    latitude: (json['latitude'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'email': instance.email,
      'description': instance.description,
      'location': instance.address,
      'city_id': instance.cityId,
      'city': instance.cityName,
      'profile_image ': instance.imageUrl,
      'cover_image': instance.coverImageUrl,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };
