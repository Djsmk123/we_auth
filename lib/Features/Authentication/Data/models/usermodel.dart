import 'package:json_annotation/json_annotation.dart';

part 'usermodel.g.dart';

@JsonSerializable()
class Usermodel {
  final String? name;
  @JsonKey(name: 'user_name')
  final String? userName;

  const Usermodel({
    this.name,
    this.userName,
  });

  factory Usermodel.fromJson(Map<String, dynamic> json) =>
      _$UsermodelFromJson(json);

  Map<String, dynamic> toJson() => _$UsermodelToJson(this);

  Usermodel copyWith({
    String? name,
    String? userName,
  }) {
    return Usermodel(
      name: name ?? this.name,
      userName: userName ?? this.userName,
    );
  }
}
