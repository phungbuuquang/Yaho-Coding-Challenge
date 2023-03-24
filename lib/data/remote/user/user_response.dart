class UserResponse {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<UserModel>? data;
  SupportModel? support;

  UserResponse(
      {this.page,
      this.perPage,
      this.total,
      this.totalPages,
      this.data,
      this.support});

  UserResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    total = json['total'];
    totalPages = json['total_pages'];
    if (json['data'] != null) {
      data = <UserModel>[];
      json['data'].forEach((v) {
        data!.add(UserModel.fromJson(v));
      });
    }
    support =
        json['support'] != null ? SupportModel.fromJson(json['support']) : null;
  }
}

class UserModel {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  UserModel({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    avatar = json['avatar'];
  }
}

class SupportModel {
  String? url;
  String? text;

  SupportModel({this.url, this.text});

  SupportModel.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    text = json['text'];
  }
}
