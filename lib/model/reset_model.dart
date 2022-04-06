class ResetPasswordModel {
  bool? status;
  String? message;
  UserDetail? userDetail;

  ResetPasswordModel({this.status, this.message, this.userDetail});

  ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userDetail = json['user_detail'] != null
        ? new UserDetail.fromJson(json['user_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
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
  String? mobileNo;
  String? email;

  UserDetail(
      {this.userId, this.firstName, this.lastName, this.mobileNo, this.email});

  UserDetail.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobileNo = json['mobile_no'].toString();
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