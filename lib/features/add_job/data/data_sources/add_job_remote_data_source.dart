
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/api_constant.dart';
import '../../../../core/error/exceptions.dart';

abstract class AddJobRemoteDataSource{
  Future<bool> addJob(Map<String,dynamic> requestBody);
}


class AddJobRemoteDataSourceImpl implements AddJobRemoteDataSource{
  http.Client client;
  AddJobRemoteDataSourceImpl(this.client);

  @override
  Future<bool> addJob(Map<String, dynamic> requestBody) async{
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    print(token);
    final response = await client.post(
      Uri.parse(
        '$kBaseUrl/job/createOrUpdate',
      ),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: requestBody,
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 220) {
      return true;
    } else if (response.statusCode == 401) {
      throw UnauthenticatedException();
    } else {
      throw ServerException();
    }
  }

}