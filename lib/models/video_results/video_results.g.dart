// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_results.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoResults _$VideoResultsFromJson(Map<String, dynamic> json) => VideoResults(
      json['success'] as bool,
      (json['data'] as List<dynamic>)
          .map((e) => ResultData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['query_time'] as int,
    );

Map<String, dynamic> _$VideoResultsToJson(VideoResults instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.resultData,
      'query_time': instance.queryTime,
    };
