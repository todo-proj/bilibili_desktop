// To parse this JSON data, do
//
//     final userInfoModel = userInfoModelFromJson(jsonString);

import 'dart:convert';

BasicUserInfoModel userInfoModelFromJson(String str) => BasicUserInfoModel.fromJson(json.decode(str));

String userInfoModelToJson(BasicUserInfoModel data) => json.encode(data.toJson());

class BasicUserInfoModel {
  final bool isLogin;
  final int emailVerified;
  final String face;
  final int faceNft;
  final int faceNftType;
  final LevelInfo levelInfo;
  final String mid;
  final int mobileVerified;
  final String money;
  final int moral;
  final Official official;
  final OfficialVerify officialVerify;
  final Pendant pendant;
  final int scores;
  final String uname;
  final int vipDueDate;
  final int vipStatus;
  final int vipType;
  final int vipPayType;
  final int vipThemeType;
  final Label vipLabel;
  final int vipAvatarSubscript;
  final String vipNicknameColor;
  final Vip vip;
  final Wallet wallet;
  final bool hasShop;
  final String shopUrl;
  final int allowanceCount;
  final int answerStatus;
  final int isSeniorMember;
  final WbiImg wbiImg;
  final bool isJury;

  BasicUserInfoModel({
    required this.isLogin,
    required this.emailVerified,
    required this.face,
    required this.faceNft,
    required this.faceNftType,
    required this.levelInfo,
    required this.mid,
    required this.mobileVerified,
    required this.money,
    required this.moral,
    required this.official,
    required this.officialVerify,
    required this.pendant,
    required this.scores,
    required this.uname,
    required this.vipDueDate,
    required this.vipStatus,
    required this.vipType,
    required this.vipPayType,
    required this.vipThemeType,
    required this.vipLabel,
    required this.vipAvatarSubscript,
    required this.vipNicknameColor,
    required this.vip,
    required this.wallet,
    required this.hasShop,
    required this.shopUrl,
    required this.allowanceCount,
    required this.answerStatus,
    required this.isSeniorMember,
    required this.wbiImg,
    required this.isJury,
  });

  factory BasicUserInfoModel.fromJson(Map<String, dynamic> json) => BasicUserInfoModel(
    isLogin: json["isLogin"],
    emailVerified: json["email_verified"],
    face: json["face"],
    faceNft: json["face_nft"],
    faceNftType: json["face_nft_type"],
    levelInfo: LevelInfo.fromJson(json["level_info"]),
    mid: json["mid"].toString(),
    mobileVerified: json["mobile_verified"],
    money: json["money"],
    moral: json["moral"],
    official: Official.fromJson(json["official"]),
    officialVerify: OfficialVerify.fromJson(json["officialVerify"]),
    pendant: Pendant.fromJson(json["pendant"]),
    scores: json["scores"],
    uname: json["uname"],
    vipDueDate: json["vipDueDate"],
    vipStatus: json["vipStatus"],
    vipType: json["vipType"],
    vipPayType: json["vip_pay_type"],
    vipThemeType: json["vip_theme_type"],
    vipLabel: Label.fromJson(json["vip_label"]),
    vipAvatarSubscript: json["vip_avatar_subscript"],
    vipNicknameColor: json["vip_nickname_color"],
    vip: Vip.fromJson(json["vip"]),
    wallet: Wallet.fromJson(json["wallet"]),
    hasShop: json["has_shop"],
    shopUrl: json["shop_url"],
    allowanceCount: json["allowance_count"] ?? 0,
    answerStatus: json["answer_status"],
    isSeniorMember: json["is_senior_member"],
    wbiImg: WbiImg.fromJson(json["wbi_img"]),
    isJury: json["is_jury"],
  );

  Map<String, dynamic> toJson() => {
    "isLogin": isLogin,
    "email_verified": emailVerified,
    "face": face,
    "face_nft": faceNft,
    "face_nft_type": faceNftType,
    "level_info": levelInfo.toJson(),
    "mid": mid,
    "mobile_verified": mobileVerified,
    "money": money,
    "moral": moral,
    "official": official.toJson(),
    "officialVerify": officialVerify.toJson(),
    "pendant": pendant.toJson(),
    "scores": scores,
    "uname": uname,
    "vipDueDate": vipDueDate,
    "vipStatus": vipStatus,
    "vipType": vipType,
    "vip_pay_type": vipPayType,
    "vip_theme_type": vipThemeType,
    "vip_label": vipLabel.toJson(),
    "vip_avatar_subscript": vipAvatarSubscript,
    "vip_nickname_color": vipNicknameColor,
    "vip": vip.toJson(),
    "wallet": wallet.toJson(),
    "has_shop": hasShop,
    "shop_url": shopUrl,
    "allowance_count": allowanceCount,
    "answer_status": answerStatus,
    "is_senior_member": isSeniorMember,
    "wbi_img": wbiImg.toJson(),
    "is_jury": isJury,
  };
}

class LevelInfo {
  final int currentLevel;
  final int currentMin;
  final int currentExp;
  final int nextExp;

  LevelInfo({
    required this.currentLevel,
    required this.currentMin,
    required this.currentExp,
    required this.nextExp,
  });

  factory LevelInfo.fromJson(Map<String, dynamic> json) => LevelInfo(
    currentLevel: json["current_level"],
    currentMin: json["current_min"],
    currentExp: json["current_exp"],
    nextExp: json["next_exp"],
  );

  Map<String, dynamic> toJson() => {
    "current_level": currentLevel,
    "current_min": currentMin,
    "current_exp": currentExp,
    "next_exp": nextExp,
  };
}

class Official {
  final int role;
  final String title;
  final String desc;
  final int type;

  Official({
    required this.role,
    required this.title,
    required this.desc,
    required this.type,
  });

  factory Official.fromJson(Map<String, dynamic> json) => Official(
    role: json["role"],
    title: json["title"],
    desc: json["desc"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "role": role,
    "title": title,
    "desc": desc,
    "type": type,
  };
}

class OfficialVerify {
  final int type;
  final String desc;

  OfficialVerify({
    required this.type,
    required this.desc,
  });

  factory OfficialVerify.fromJson(Map<String, dynamic> json) => OfficialVerify(
    type: json["type"],
    desc: json["desc"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "desc": desc,
  };
}

class Pendant {
  final int pid;
  final String name;
  final String image;
  final int expire;
  final String imageEnhance;
  final String imageEnhanceFrame;

  Pendant({
    required this.pid,
    required this.name,
    required this.image,
    required this.expire,
    required this.imageEnhance,
    required this.imageEnhanceFrame,
  });

  factory Pendant.fromJson(Map<String, dynamic> json) => Pendant(
    pid: json["pid"],
    name: json["name"],
    image: json["image"],
    expire: json["expire"],
    imageEnhance: json["image_enhance"],
    imageEnhanceFrame: json["image_enhance_frame"],
  );

  Map<String, dynamic> toJson() => {
    "pid": pid,
    "name": name,
    "image": image,
    "expire": expire,
    "image_enhance": imageEnhance,
    "image_enhance_frame": imageEnhanceFrame,
  };
}

class Vip {
  final int type;
  final int status;
  final int dueDate;
  final int vipPayType;
  final int themeType;
  final Label label;
  final int avatarSubscript;
  final String nicknameColor;
  final int role;
  final String avatarSubscriptUrl;
  final int tvVipStatus;
  final int tvVipPayType;
  final int tvDueDate;

  Vip({
    required this.type,
    required this.status,
    required this.dueDate,
    required this.vipPayType,
    required this.themeType,
    required this.label,
    required this.avatarSubscript,
    required this.nicknameColor,
    required this.role,
    required this.avatarSubscriptUrl,
    required this.tvVipStatus,
    required this.tvVipPayType,
    required this.tvDueDate,
  });

  factory Vip.fromJson(Map<String, dynamic> json) => Vip(
    type: json["type"],
    status: json["status"],
    dueDate: json["due_date"],
    vipPayType: json["vip_pay_type"],
    themeType: json["theme_type"],
    label: Label.fromJson(json["label"]),
    avatarSubscript: json["avatar_subscript"],
    nicknameColor: json["nickname_color"],
    role: json["role"],
    avatarSubscriptUrl: json["avatar_subscript_url"],
    tvVipStatus: json["tv_vip_status"],
    tvVipPayType: json["tv_vip_pay_type"],
    tvDueDate: json["tv_due_date"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "status": status,
    "due_date": dueDate,
    "vip_pay_type": vipPayType,
    "theme_type": themeType,
    "label": label.toJson(),
    "avatar_subscript": avatarSubscript,
    "nickname_color": nicknameColor,
    "role": role,
    "avatar_subscript_url": avatarSubscriptUrl,
    "tv_vip_status": tvVipStatus,
    "tv_vip_pay_type": tvVipPayType,
    "tv_due_date": tvDueDate,
  };
}

class Label {
  final String path;
  final String text;
  final String labelTheme;
  final String textColor;
  final int bgStyle;
  final String bgColor;
  final String borderColor;
  final bool useImgLabel;
  final String imgLabelUriHans;
  final String imgLabelUriHant;
  final String imgLabelUriHansStatic;
  final String imgLabelUriHantStatic;

  Label({
    required this.path,
    required this.text,
    required this.labelTheme,
    required this.textColor,
    required this.bgStyle,
    required this.bgColor,
    required this.borderColor,
    required this.useImgLabel,
    required this.imgLabelUriHans,
    required this.imgLabelUriHant,
    required this.imgLabelUriHansStatic,
    required this.imgLabelUriHantStatic,
  });

  factory Label.fromJson(Map<String, dynamic> json) => Label(
    path: json["path"],
    text: json["text"],
    labelTheme: json["label_theme"],
    textColor: json["text_color"],
    bgStyle: json["bg_style"],
    bgColor: json["bg_color"],
    borderColor: json["border_color"],
    useImgLabel: json["use_img_label"],
    imgLabelUriHans: json["img_label_uri_hans"],
    imgLabelUriHant: json["img_label_uri_hant"],
    imgLabelUriHansStatic: json["img_label_uri_hans_static"],
    imgLabelUriHantStatic: json["img_label_uri_hant_static"],
  );

  Map<String, dynamic> toJson() => {
    "path": path,
    "text": text,
    "label_theme": labelTheme,
    "text_color": textColor,
    "bg_style": bgStyle,
    "bg_color": bgColor,
    "border_color": borderColor,
    "use_img_label": useImgLabel,
    "img_label_uri_hans": imgLabelUriHans,
    "img_label_uri_hant": imgLabelUriHant,
    "img_label_uri_hans_static": imgLabelUriHansStatic,
    "img_label_uri_hant_static": imgLabelUriHantStatic,
  };
}

class Wallet {
  final int mid;
  final int bcoinBalance;
  final int couponBalance;
  final int couponDueTime;

  Wallet({
    required this.mid,
    required this.bcoinBalance,
    required this.couponBalance,
    required this.couponDueTime,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
    mid: json["mid"],
    bcoinBalance: json["bcoin_balance"],
    couponBalance: json["coupon_balance"],
    couponDueTime: json["coupon_due_time"],
  );

  Map<String, dynamic> toJson() => {
    "mid": mid,
    "bcoin_balance": bcoinBalance,
    "coupon_balance": couponBalance,
    "coupon_due_time": couponDueTime,
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
