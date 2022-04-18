import 'package:atomic_assets/models/data/data.dart';
import 'package:atomic_assets/models/result_data/result_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'video_results.g.dart';

@JsonSerializable()
class VideoResults {
  VideoResults(this.success, this.resultData, this.queryTime);

  bool success;
  @JsonKey(name: 'data')
  List<ResultData> resultData;
  @JsonKey(name: 'query_time')
  int queryTime;

  factory VideoResults.fromJson(Map<String, dynamic> json) =>
      _$VideoResultsFromJson(json);

  Map<String, dynamic> toJson() => _$VideoResultsToJson(this);
}
