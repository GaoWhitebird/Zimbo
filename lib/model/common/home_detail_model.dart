import 'package:zimbo/model/common/summary_model.dart';

class HomeDetailModel {
  String? title;
  String? total;
  List<SummaryModel>? summaryList;
  
  HomeDetailModel({
    this.title = '',
    this.total = '',
    this.summaryList = const [],
  });

  Map<String, dynamic> toJson () => {
    'title': title,
    'total': total,
    'summary_list': summaryList,
  };

  factory HomeDetailModel.fromJson(Map<String, dynamic> json) => HomeDetailModel(
    title: json['title'],
    total: json['total'],
    summaryList: json['summary_list'],
  );
}