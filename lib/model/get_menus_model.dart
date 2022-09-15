class GetMenusModel {
  String? userName;
  int? userMobile;
  String? userImage;
  List<String>? menus;

  GetMenusModel({this.userName, this.userMobile, this.userImage, this.menus});

  GetMenusModel.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    userMobile = json['user_mobile'];
    userImage = json['user_image'];
    menus = json['menus'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['user_mobile'] = this.userMobile;
    data['user_image'] = this.userImage;
    data['menus'] = this.menus;
    return data;
  }
}
