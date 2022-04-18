import 'package:atomic_assets/models/data/data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'result_data.g.dart';

@JsonSerializable()
class ResultData {
  ResultData(this.data);

  Data data;

  factory ResultData.fromJson(Map<String, dynamic> json) =>
      _$ResultDataFromJson(json);

  Map<String, dynamic> toJson() => _$ResultDataToJson(this);
}
