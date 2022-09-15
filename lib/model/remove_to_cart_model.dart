class RemoveToCartModel {
  bool? status;
  String? message;
  // List<Null>? result;

  RemoveToCartModel({this.status, this.message, /*this.result*/});

  RemoveToCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    // if (json['result'] != null) {
    //   result = <Null>[];
    //   json['result'].forEach((v) {
    //     result!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    // if (this.result != null) {
    //   data['result'] = this.result!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}
