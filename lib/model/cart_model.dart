class CartModel {
  bool? status;
  String? message;
  Result? result;

  CartModel({this.status, this.message, this.result});

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
    json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class Result {
  List<Cart>? cart;
  int? totalCount;

  Result({this.cart, this.totalCount});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['cart'] != null) {
      cart = <Cart>[];
      json['cart'].forEach((v) {
        cart!.add(Cart.fromJson(v));
      });
    }
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (cart != null) {
      data['cart'] = cart!.map((Cart v) => v.toJson()).toList();
    }
    data['total_count'] = totalCount;
    return data;
  }
}

class Cart {
  int? id;
  int? userId;
  String? categoryId;
  String? courseCategoryLang1;
  String? packageId;
  String? packageNameLang1;
  String? languages;
  String? examType;
  String? noOfTest;
  String? packageType;
  String? startDate;
  String? qty;
  String? lang;
  String? tax;
  String? price;
  String? total;
  String? status;
  String? createdAt;

  Cart(
      {this.id,
        this.userId,
        this.categoryId,
        this.courseCategoryLang1,
        this.packageId,
        this.packageNameLang1,
        this.languages,
        this.examType,
        this.noOfTest,
        this.packageType,
        this.startDate,
        this.qty,
        this.lang,
        this.tax,
        this.price,
        this.total,
        this.status,
        this.createdAt});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    categoryId = json['category_id'];
    courseCategoryLang1 = json['course_category_lang1'];
    packageId = json['package_id'];
    packageNameLang1 = json['package_name_lang1'];
    languages = json['languages'];
    examType = json['exam_type'];
    noOfTest = json['no_of_test'];
    packageType = json['package_type'];
    startDate = json['start_date'];
    qty = json['qty'];
    lang = json['lang'];
    tax = json['tax'];
    price = json['price'];
    total = json['total'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['category_id'] = categoryId;
    data['course_category_lang1'] = courseCategoryLang1;
    data['package_id'] = packageId;
    data['package_name_lang1'] = packageNameLang1;
    data['languages'] = languages;
    data['exam_type'] = examType;
    data['no_of_test'] = noOfTest;
    data['package_type'] = packageType;
    data['start_date'] = startDate;
    data['qty'] = qty;
    data['lang'] = lang;
    data['tax'] = tax;
    data['price'] = price;
    data['total'] = total;
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }
}
