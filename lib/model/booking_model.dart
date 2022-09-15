class BookingModel {
  bool? status;
  String? message;
  Result? result;

  BookingModel({this.status, this.message, this.result});

  BookingModel.fromJson(Map<String, dynamic> json) {
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
  Package? package;
  List<Gender>? gender;
  List<Medium>? medium;
  List<Qualification>? qualification;
  StudentInformation? studentInformation;

  Result(
      {this.package,
         this.gender,
         this.medium,
         this.qualification,
         this.studentInformation
      });

  Result.fromJson(Map<String, dynamic> json) {
    package =
    json['package'] != null ? new Package.fromJson(json['package']) : null;
    if (json['gender'] != null) {
      gender = <Gender>[];
      json['gender'].forEach((v) {
        gender!.add(new Gender.fromJson(v));
      });
    }
    if (json['medium'] != null) {
      medium = <Medium>[];
      json['medium'].forEach((v) {
        medium!.add(new Medium.fromJson(v));
      });
    }
    if (json['qualification'] != null) {
      qualification = <Qualification>[];
      json['qualification'].forEach((v) {
        qualification!.add(new Qualification.fromJson(v));
      });
    }
    studentInformation = json['studentInformation'] != null
        ? new StudentInformation.fromJson(json['studentInformation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.package != null) {
      data['package'] = this.package!.toJson();
    }
    if (this.gender != null) {
      data['gender'] = this.gender!.map((v) => v.toJson()).toList();
    }
    if (this.medium != null) {
      data['medium'] = this.medium!.map((v) => v.toJson()).toList();
    }
    if (this.qualification != null) {
      data['qualification'] =
          this.qualification!.map((v) => v.toJson()).toList();
    }
    if (this.studentInformation != null) {
      data['studentInformation'] = this.studentInformation!.toJson();
    }
    return data;
  }
}

class Package {
  int? id;
  String? packageNameLang1;
  String? languages;
  String? examType;
  String? noOfTest;
  int? feesForNew;

  Package(
      {this.id,
        this.packageNameLang1,
        this.languages,
        this.examType,
        this.noOfTest,
        this.feesForNew});

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packageNameLang1 = json['package_name_lang1'];
    languages = json['languages'];
    examType = json['exam_type'];
    noOfTest = json['no_of_test'];
    feesForNew = json['fees_for_new'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['package_name_lang1'] = this.packageNameLang1;
    data['languages'] = this.languages;
    data['exam_type'] = this.examType;
    data['no_of_test'] = this.noOfTest;
    data['fees_for_new'] = this.feesForNew;
    return data;
  }
}

class Gender {
  String? id;
  String? genderName;

  Gender({this.id, this.genderName});

  Gender.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    genderName = json['gender_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gender_name'] = this.genderName;
    return data;
  }
}

class Medium {
  String? id;
  String? medium;

  Medium({this.id, this.medium});

  Medium.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    medium = json['medium'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['medium'] = this.medium;
    return data;
  }
}

class Qualification {
  String? name;

  Qualification({this.name});

  Qualification.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class StudentInformation {
  String? studentImage;
  String? name;
  String? dob;
  int? mobileNo;
  String? email;
  dynamic gender;
  String? langKnown;
  String? medium;
  String? sslc;
  String? schoolName;
  dynamic passingYearSl;
  dynamic schoolPercentage;
  String? hsc;
  String? highSchoolName;
  dynamic passingYearHs;
  dynamic highSchoolPercentage;
  String? ug;
  String? ugDegree;
  dynamic passingYearUg;
  dynamic ugPercentage;
  String? pg;
  dynamic passingYearPg;
  dynamic pgPercentage;

  StudentInformation(
      {this.studentImage,
        this.name,
        this.dob,
        this.mobileNo,
        this.email,
        this.gender,
        this.langKnown,
        this.medium,
        this.sslc,
        this.schoolName,
        this.passingYearSl,
        this.schoolPercentage,
        this.hsc,
        this.highSchoolName,
        this.passingYearHs,
        this.highSchoolPercentage,
        this.ug,
        this.ugDegree,
        this.passingYearUg,
        this.ugPercentage,
        this.pg,
        this.passingYearPg,
        this.pgPercentage
      });

  StudentInformation.fromJson(Map<String, dynamic> json) {
    studentImage = json['student_image'];
    name = json['name'];
    dob = json['dob'];
    mobileNo = json['mobile_no'];
    email = json['email'];
    gender = json['gender'];
    langKnown = json['lang_known'];
    medium = json['medium'];
    sslc = json['sslc'];
    schoolName = json['school_name'];
    passingYearSl = json['passing_year_sl'];
    schoolPercentage = json['school_percentage'];
    hsc = json['hsc'];
    highSchoolName = json['high_school_name'];
    passingYearHs = json['passing_year_hs'];
    highSchoolPercentage = json['high_school_percentage'];
    ug = json['ug'];
    ugDegree = json['ug_degree'];
    passingYearUg = json['passing_year_ug'];
    ugPercentage = json['ug_percentage'];
    pg = json['pg'];
    passingYearPg = json['passing_year_pg'];
    pgPercentage = json['pg_percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['student_image'] = this.studentImage;
    data['name'] = this.name;
    data['dob'] = this.dob;
    data['mobile_no'] = this.mobileNo;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['lang_known'] = this.langKnown;
    data['medium'] = this.medium;
    data['sslc'] = this.sslc;
    data['school_name'] = this.schoolName;
    data['passing_year_sl'] = this.passingYearSl;
    data['school_percentage'] = this.schoolPercentage;
    data['hsc'] = this.hsc;
    data['high_school_name'] = this.highSchoolName;
    data['passing_year_hs'] = this.passingYearHs;
    data['high_school_percentage'] = this.highSchoolPercentage;
    data['ug'] = this.ug;
    data['ug_degree'] = this.ugDegree;
    data['passing_year_ug'] = this.passingYearUg;
    data['ug_percentage'] = this.ugPercentage;
    data['pg'] = this.pg;
    data['passing_year_pg'] = this.passingYearPg;
    data['pg_percentage'] = this.pgPercentage;
    return data;
  }
}