import 'package:zimbo/model/common/profile_level_model.dart';
import 'package:zimbo/model/common/user_model.dart';

import 'profile_insight_model.dart';

class DashModel {
  String? available;
  UserModel? userModel;
  ProfileInsightModel? insightModel;
  List<ProfileLevelModel>? levelList;
  
  DashModel({
    this.available = '0',
    this.userModel,
    this.insightModel,
    this.levelList = const [],
  });

  Map<String, dynamic> toJson () => {
    'available': available,
    'level_list': levelList,
    'insight_list': insightModel,
    'user_info': userModel,
  };

  factory DashModel.fromJson(Map<String, dynamic> json) => DashModel(
    available: json['available'],
    levelList: json['level_list'],
    insightModel: json['insight_list'],
    userModel: json['user_info'],
  );
}