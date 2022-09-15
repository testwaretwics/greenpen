class BuyTestModel {
  bool? status;
  String? message;
  Result? result;

  BuyTestModel({this.status, this.message, this.result});

  BuyTestModel.fromJson(Map<String, dynamic> json) {
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
  List<Category>? category;
  List<PackageDetail>? packageDetail;

  Result({this.category, this.packageDetail});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
    if (json['package_detail'] != null) {
      packageDetail = <PackageDetail>[];
      json['package_detail'].forEach((v) {
        packageDetail!.add(new PackageDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    if (this.packageDetail != null) {
      data['package_detail'] =
          this.packageDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }

}

class Category {
  int? id;
  String? courseCategoryLang1;

  Category({this.id, this.courseCategoryLang1});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    courseCategoryLang1 = json['course_category_lang1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['course_category_lang1'] = this.courseCategoryLang1;
    return data;
  }
}

class PackageDetail {
  int? categoryId;
  String? courseCategoryLang1;
  int? packageId;
  String? packageNameLang1;
  String? languages;
  String? packageType;
  String? examType;
  String? noOfTest;
  String? startDate;
  String? packageVersion;
  int? feesForNew;
  String? cartStatus;
  int? orderStatus;

  PackageDetail(
      {this.categoryId,
        this.courseCategoryLang1,
        this.packageId,
        this.packageNameLang1,
        this.languages,
        this.packageType,
        this.examType,
        this.noOfTest,
        this.startDate,
        this.packageVersion,
        this.feesForNew,
        this.cartStatus,
        this.orderStatus});

  PackageDetail.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    courseCategoryLang1 = json['course_category_lang1'];
    packageId = json['package_id'];
    packageNameLang1 = json['package_name_lang1'];
    languages = json['languages'];
    packageType = json['package_type'];
    examType = json['exam_type'];
    noOfTest = json['no_of_test'];
    startDate = json['start_date'];
    packageVersion = json['package_version'];
    feesForNew = json['fees_for_new'];
    cartStatus = json['cart_status'];
    orderStatus = json['order_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['course_category_lang1'] = this.courseCategoryLang1;
    data['package_id'] = this.packageId;
    data['package_name_lang1'] = this.packageNameLang1;
    data['languages'] = this.languages;
    data['package_type'] = this.packageType;
    data['exam_type'] = this.examType;
    data['no_of_test'] = this.noOfTest;
    data['start_date'] = this.startDate;
    data['package_version'] = this.packageVersion;
    data['fees_for_new'] = this.feesForNew;
    data['cart_status'] = this.cartStatus;
    data['order_status'] = this.orderStatus;
    return data;
  }
}