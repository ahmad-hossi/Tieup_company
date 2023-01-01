import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/api_constant.dart';
import '../../../../core/error/exceptions.dart';
import '../models/profile_model.dart';
import 'package:dio/dio.dart';

abstract class ProfileRemoteDataSource{
  Future<ProfileModel> getProfileInformation();
  Future<bool> updateProfileInformation(Map<String,dynamic> requestBody);
  Future<bool> updateCompanyImage(File imageFile, String type,int companyId);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource{
  http.Client client;
  ProfileRemoteDataSourceImpl(this.client);

  @override
  Future<ProfileModel> getProfileInformation() async{
     //try{
       final prefs = await SharedPreferences.getInstance();
       final token = prefs.getString('token');
       final response = await client.get(
         Uri.parse(
           '$kBaseUrl/company/get'
         ),
         headers: {
           'Accept': 'application/json',
           'Authorization': 'Bearer $token',
         },
       );
       print(response.body);
       if(response.statusCode == 210){
         return ProfileModel.fromJson(json.decode(response.body)['data']);
       }
       else if(response.statusCode == 401) {
         throw UnauthenticatedException();
       }else {
         throw ServerException();
       }
     // }catch(e){
     //   throw ServerException();
     // }


  }

  @override
  Future<bool> updateProfileInformation(Map<String, dynamic> requestBody) async{
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await client.post(
      Uri.parse(
          '$kBaseUrl/company/update'
      ),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: requestBody
    );
    print(response.body);
    if(response.statusCode == 240){
      return true;
    }
    else if(response.statusCode == 401) {
      throw UnauthenticatedException();
    }else {
      throw ServerException();
    }
  }

  @override
  Future<bool> updateCompanyImage(File imageFile, String type,int companyId) async{
    print('hello again');
    final prefs = await SharedPreferences.getInstance();
    try{
      final token = prefs.getString('token');
      String url = '$kBaseUrl/api/photo/upload';
      var dio = Dio();
      Options options = Options(
          followRedirects: false,
          validateStatus: (status) { return status! < 500; }
      );
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(imageFile.path),
        "type": type,
        "id" : companyId.toString()
      });
      options.headers = { "Authorization" : "Bearer $token" , "Accept":"application/json"} ;
      var response = await dio.post(url, data: formData,options: options );
      print(response.data);
      print(response.statusCode);
      if(response.statusCode == 220){
        print('image true');
        return true;
      }
      else {
        throw ServerException();
      }
    }catch(e){
      throw ServerException();
    }
  }

}