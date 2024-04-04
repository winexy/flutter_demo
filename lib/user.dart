import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String login;

  @JsonKey(name: 'avatar_url')
  final String avatarUrl;

  const User({required this.login, required this.avatarUrl});

  factory User.fromJson(Map<String, Object?> json) 
    => _$UserFromJson(json);
}
