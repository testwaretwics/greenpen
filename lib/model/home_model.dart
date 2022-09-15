class HomeModel {
  String? userName;
  String? userImage;
  String? lastLogin;
  List<RankScoredRecently>? rankScoredRecently;
  SummaryForTest? summaryForTest;

  HomeModel(
      {this.userName,
        this.userImage,
        this.lastLogin,
        this.rankScoredRecently,
        this.summaryForTest});

  HomeModel.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    userImage = json['user_image'];
    lastLogin = json['last_login'];
    if (json['rank_scored_recently'] != null) {
      rankScoredRecently = <RankScoredRecently>[];
      json['rank_scored_recently'].forEach((v) {
        rankScoredRecently!.add(new RankScoredRecently.fromJson(v));
      });
    }
    summaryForTest = json['summary_for_test'] != null
        ? new SummaryForTest.fromJson(json['summary_for_test'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['user_image'] = this.userImage;
    data['last_login'] = this.lastLogin;
    if (this.rankScoredRecently != null) {
      data['rank_scored_recently'] =
          this.rankScoredRecently!.map((v) => v.toJson()).toList();
    }
    if (this.summaryForTest != null) {
      data['summary_for_test'] = this.summaryForTest!.toJson();
    }
    return data;
  }
}

class RankScoredRecently {
  String? title;
  double? mark;
  int? totalMark;
  String? rank;

  RankScoredRecently({this.title, this.mark, this.totalMark, this.rank});

  RankScoredRecently.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    mark = double.parse(json['mark'].toString());
    totalMark = json['total_mark'];
    rank = json['rank'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['mark'] = this.mark;
    data['total_mark'] = this.totalMark;
    data['rank'] = this.rank;
    return data;
  }
}

class SummaryForTest {
  int? incompletedTest;
  int? completedTest;
  int? pendingTest;
  int? percentage;

  SummaryForTest(
      {this.incompletedTest,
        this.completedTest,
        this.pendingTest,
        this.percentage});

  SummaryForTest.fromJson(Map<String, dynamic> json) {
    incompletedTest = json['incompleted_test'];
    completedTest = json['completed_test'];
    pendingTest = json['pending_test'];
    percentage = json['percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['incompleted_test'] = this.incompletedTest;
    data['completed_test'] = this.completedTest;
    data['pending_test'] = this.pendingTest;
    data['percentage'] = this.percentage;
    return data;
  }
}