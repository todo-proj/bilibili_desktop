// To parse this JSON data, do
//
//     final simpleUserCardModel = simpleUserCardModelFromJson(jsonString);

import 'dart:convert';

class SimpleUserCardModel {
  final Map<String, SimpleUserCard> users;

  SimpleUserCardModel({required this.users});

  factory SimpleUserCardModel.fromJson(Map<String, dynamic> json) =>
      SimpleUserCardModel(
        users: json.map((k, v) => MapEntry(k, SimpleUserCard.fromJson(v))),
      );

  Map<String, dynamic> toJson() {
    return {for (var item in users.values) item.mid: item.toJson()};
  }
}

class SimpleUserCard {
  final String mid;
  final String face;
  final String name;
  final Official official;
  final Vip vip;
  final dynamic nameRender;

  SimpleUserCard({
    required this.mid,
    required this.face,
    required this.name,
    required this.official,
    required this.vip,
    required this.nameRender,
  });

  factory SimpleUserCard.fromJson(Map<String, dynamic> json) => SimpleUserCard(
    mid: json["mid"],
    face: json["face"],
    name: json["name"],
    official: Official.fromJson(json["official"]),
    vip: Vip.fromJson(json["vip"]),
    nameRender: json["name_render"],
  );

  Map<String, dynamic> toJson() => {
    "mid": mid,
    "face": face,
    "name": name,
    "official": official.toJson(),
    "vip": vip.toJson(),
    "name_render": nameRender,
  };
}

class Official {
  final String desc;
  final int role;
  final String title;
  final int type;

  Official({
    required this.desc,
    required this.role,
    required this.title,
    required this.type,
  });

  factory Official.fromJson(Map<String, dynamic> json) => Official(
    desc: json["desc"],
    role: json["role"],
    title: json["title"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "desc": desc,
    "role": role,
    "title": title,
    "type": type,
  };
}

class Vip {
  final int avatarSubscript;
  final String avatarSubscriptUrl;
  final String dueDate;
  final String nicknameColor;
  final String role;
  final int status;
  final int themeType;
  final int type;
  final Label label;

  Vip({
    required this.avatarSubscript,
    required this.avatarSubscriptUrl,
    required this.dueDate,
    required this.nicknameColor,
    required this.role,
    required this.status,
    required this.themeType,
    required this.type,
    required this.label,
  });

  factory Vip.fromJson(Map<String, dynamic> json) => Vip(
    avatarSubscript: json["avatar_subscript"],
    avatarSubscriptUrl: json["avatar_subscript_url"],
    dueDate: json["due_date"],
    nicknameColor: json["nickname_color"],
    role: json["role"],
    status: json["status"],
    themeType: json["theme_type"],
    type: json["type"],
    label: Label.fromJson(json["label"]),
  );

  Map<String, dynamic> toJson() => {
    "avatar_subscript": avatarSubscript,
    "avatar_subscript_url": avatarSubscriptUrl,
    "due_date": dueDate,
    "nickname_color": nicknameColor,
    "role": role,
    "status": status,
    "theme_type": themeType,
    "type": type,
    "label": label.toJson(),
  };
}

class Label {
  final String bgColor;
  final int bgStyle;
  final String borderColor;
  final String imgLabelUriHans;
  final String imgLabelUriHansStatic;
  final String imgLabelUriHant;
  final String imgLabelUriHantStatic;
  final String labelTheme;
  final String path;
  final String text;
  final String textColor;
  final bool useImgLabel;

  Label({
    required this.bgColor,
    required this.bgStyle,
    required this.borderColor,
    required this.imgLabelUriHans,
    required this.imgLabelUriHansStatic,
    required this.imgLabelUriHant,
    required this.imgLabelUriHantStatic,
    required this.labelTheme,
    required this.path,
    required this.text,
    required this.textColor,
    required this.useImgLabel,
  });

  factory Label.fromJson(Map<String, dynamic> json) => Label(
    bgColor: json["bg_color"],
    bgStyle: json["bg_style"],
    borderColor: json["border_color"],
    imgLabelUriHans: json["img_label_uri_hans"],
    imgLabelUriHansStatic: json["img_label_uri_hans_static"],
    imgLabelUriHant: json["img_label_uri_hant"],
    imgLabelUriHantStatic: json["img_label_uri_hant_static"],
    labelTheme: json["label_theme"],
    path: json["path"],
    text: json["text"],
    textColor: json["text_color"],
    useImgLabel: json["use_img_label"],
  );

  Map<String, dynamic> toJson() => {
    "bg_color": bgColor,
    "bg_style": bgStyle,
    "border_color": borderColor,
    "img_label_uri_hans": imgLabelUriHans,
    "img_label_uri_hans_static": imgLabelUriHansStatic,
    "img_label_uri_hant": imgLabelUriHant,
    "img_label_uri_hant_static": imgLabelUriHantStatic,
    "label_theme": labelTheme,
    "path": path,
    "text": text,
    "text_color": textColor,
    "use_img_label": useImgLabel,
  };
}
