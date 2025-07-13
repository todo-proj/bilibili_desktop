// To parse this JSON data, do
//
//     final userInfoModel = userInfoModelFromJson(jsonString);

import 'dart:convert';

WbiImgModel userInfoModelFromJson(String str) => WbiImgModel.fromJson(json.decode(str));

String userInfoModelToJson(WbiImgModel data) => json.encode(data.toJson());

class WbiImgModel {
  final bool isLogin;
  final WbiImg wbiImg;

  WbiImgModel({
    required this.isLogin,
    required this.wbiImg,
  });

  factory WbiImgModel.fromJson(Map<String, dynamic> json) => WbiImgModel(
    isLogin: json["isLogin"],
    wbiImg: WbiImg.fromJson(json["wbi_img"]),
  );

  Map<String, dynamic> toJson() => {
    "isLogin": isLogin,
    "wbi_img": wbiImg.toJson(),
  };
}

class WbiImg {
  final String imgUrl;
  final String subUrl;

  WbiImg({
    required this.imgUrl,
    required this.subUrl,
  });

  factory WbiImg.fromJson(Map<String, dynamic> json) => WbiImg(
    imgUrl: json["img_url"],
    subUrl: json["sub_url"],
  );

  Map<String, dynamic> toJson() => {
    "img_url": imgUrl,
    "sub_url": subUrl,
  };
}
