import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  final int? id;
  final String? name;
  final String? email;
  final String? gender;
  final String? status;
  final String? created_at;
  final String? updated_at;

  const User({
      required this.id,
      required this.name,
      required this.email,
      required this.gender,
      required this.status,
      required this.created_at,
      required this.updated_at
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}