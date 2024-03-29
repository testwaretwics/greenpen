class ForgotPasswordModel {
  bool? status;
  String? message;
  UserDetail? userDetail;

  ForgotPasswordModel({this.status, this.message, this.userDetail});

  ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
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
  int? otp;
  int? userId;
  int? mobileNo;

  UserDetail({this.otp, this.userId, this.mobileNo});

  UserDetail.fromJson(Map<String, dynamic> json) {
    otp = json['otp'];
    userId = json['user_id'];
    mobileNo = json['mobile_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otp'] = this.otp;
    data['user_id'] = this.userId;
    data['mobile_no'] = this.mobileNo;
    return data;
  }
}