class TestTimeTableModel {
  List<TestTimeTable>? testTimeTable;

  TestTimeTableModel({this.testTimeTable});

  TestTimeTableModel.fromJson(Map<String, dynamic> json) {
    if (json['test_time_table'] != null) {
      testTimeTable = <TestTimeTable>[];
      json['test_time_table'].forEach((v) {
        testTimeTable!.add(new TestTimeTable.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.testTimeTable != null) {
      data['test_time_table'] =
          this.testTimeTable!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TestTimeTable {
  int? testId;
  int? packageId;
  String? testTitle;
  String? examType;
  String? testTime;
  int? testStatus;

  TestTimeTable(
      {this.testId,
        this.packageId,
        this.testTitle,
        this.examType,
        this.testTime,
        this.testStatus});

  TestTimeTable.fromJson(Map<String, dynamic> json) {
    testId = json['test_id'];
    packageId = json['package_id'];
    testTitle = json['test_title'];
    examType = json['exam_type'];
    testTime = json['test_time'];
    testStatus = json['test_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['test_id'] = this.testId;
    data['package_id'] = this.packageId;
    data['test_title'] = this.testTitle;
    data['exam_type'] = this.examType;
    data['test_time'] = this.testTime;
    data['test_status'] = this.testStatus;
    return data;
  }
}