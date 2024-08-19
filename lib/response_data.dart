
import 'package:json_annotation/json_annotation.dart';
part 'response_data.g.dart';

@JsonSerializable()
class ResponseData {
  final int code;
  final dynamic meta;
  final List<dynamic> data;

  const ResponseData({required this.code, required this.meta, required this.data});

  factory ResponseData.fromJson(Map<String, dynamic> json) => _$ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseDataToJson(this);
}