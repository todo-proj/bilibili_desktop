import 'package:json_annotation/json_annotation.dart';

part 'login_qr_code_model.g.dart';

@JsonSerializable()
class LoginQRCodeModel {
  final String url;
  @JsonKey(name: 'qrcode_key')
  final String qrcodeKey;


  LoginQRCodeModel({
    required this.url,
    required this.qrcodeKey,
  });

  factory LoginQRCodeModel.fromJson(Map<String, dynamic> json) =>
      _$LoginQRCodeModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginQRCodeModelToJson(this);
}