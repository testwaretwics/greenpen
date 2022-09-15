class ProfileModel {
  bool? status;
  String? message;
  Result? result;

  ProfileModel({this.status, this.message, this.result});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  int? id;
  String? firstName;
  String? lastName;
  int? mobileNo;
  String? email;
  String? studentImage;
  // Null? deviceId;
  String? accessToken;
  int? status;

  Result(
      {this.id,
        this.firstName,
        this.lastName,
        this.mobileNo,
        this.email,
        this.studentImage,
        // this.deviceId,
        this.accessToken,
        this.status});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    mobileNo = json['mobile_no'];
    email = json['email'];
    studentImage = json['student_image'];
    // deviceId = json['device_id'];
    accessToken = json['access_token'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['mobile_no'] = this.mobileNo;
    data['email'] = this.email;
    data['student_image'] = this.studentImage;
    // data['device_id'] = this.deviceId;
    data['access_token'] = this.accessToken;
    data['status'] = this.status;
    return data;
  }
}
