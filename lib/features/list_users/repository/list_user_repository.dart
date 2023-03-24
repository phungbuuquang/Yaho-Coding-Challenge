import 'package:yahoapp/data/remote/user/user_response.dart';
import 'package:yahoapp/services/api_client.dart';

class ListUserRepository {
  ListUserRepository._privateConstructor();

  static final ListUserRepository _instance =
      ListUserRepository._privateConstructor();

  static ListUserRepository get instance => _instance;

  Future<UserResponse?> getListUsers({int page = 1}) async {
    try {
      final res = await ApiClientImpl.instance.getUsers(page: page);
      return res;
    } catch (_) {
      return null;
    }
  }
}
