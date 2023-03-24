import 'dart:convert';

import 'package:yahoapp/data/remote/user/user_response.dart';
import 'package:http/http.dart' as http;

abstract class ApiClient {
  Future<UserResponse> getUsers({int page = 1});
}

class ApiClientImpl extends ApiClient {
  ApiClientImpl._privateConstructor();

  static final ApiClientImpl _instance = ApiClientImpl._privateConstructor();

  static ApiClientImpl get instance => _instance;

  @override
  Future<UserResponse> getUsers({int page = 1}) async {
    final response =
        await http.get(Uri.parse('https://reqres.in/api/users?page=$page'));

    if (response.statusCode == 200) {
      return UserResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
}
