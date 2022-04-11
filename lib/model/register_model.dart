class RegisterModel {
  bool? status;
  String? message;
  String? tokenType;
  String? jwtToken;
  List<UserDetail>? userDetail;

  RegisterModel(
      {this.status,
        this.message,
        this.tokenType,
        this.jwtToken,
        this.userDetail
      });

  RegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    tokenType = json['token_type'];
    jwtToken = json['jwt_token'];

    if (json['user_detail'] != null) {
      userDetail = new List<UserDetail>.empty(growable: true);
      json['user_detail'].forEach((v) {
        userDetail!.add(new UserDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['token_type'] = this.tokenType;
    data['jwt_token'] = this.jwtToken;
    if (this.userDetail != null) {
      data['user_detail'] = this.userDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserDetail {
  int? otp;
  int? userId;
  String? firstName;
  String? lastName;
  String? mobileNo;
  String? email;

  UserDetail(
      {this.otp,
        this.userId,
        this.firstName,
        this.lastName,
        this.mobileNo,
        this.email});

  UserDetail.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobileNo = json['mobile_no'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otp'] = this.otp;
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['mobile_no'] = this.mobileNo;
    data['email'] = this.email;
    return data;
  }
}