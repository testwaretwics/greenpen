class LoginModel {
  bool? status;
  String? message;
  String? tokenType;
  String? jwtToken;
  UserDetail? userDetail;

  LoginModel(
      {this.status,
        this.message,
        this.tokenType,
        this.jwtToken,
        this.userDetail});

  LoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    tokenType = json['token_type'];
    jwtToken = json['jwt_token'];
    userDetail = json['user_detail'] != null
        ? new UserDetail.fromJson(json['user_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['token_type'] = this.tokenType;
    data['jwt_token'] = this.jwtToken;
    if (this.userDetail != null) {
      data['user_detail'] = this.userDetail!.toJson();
    }
    return data;
  }
}

class UserDetail {
  int? userId;
  String? firstName;
  String? lastName;
  int? mobileNo;
  String? email;

  UserDetail(
      {this.userId, this.firstName, this.lastName, this.mobileNo, this.email});

  UserDetail.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobileNo = json['mobile_no'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['mobile_no'] = this.mobileNo;
    data['email'] = this.email;
    return data;
  }
}