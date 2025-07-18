import 'package:json_annotation/json_annotation.dart';

part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  final int code;
  @JsonKey(defaultValue: '')
  final String message;
  final T? data;
  final T? result;

  ApiResponse({
    required this.code,
    required this.message,
    this.data,
    this.result,
  });

  factory ApiResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,
      ) =>
      _$ApiResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ApiResponseToJson(this, toJsonT);

  bool get isSuccess => code == 0;
}