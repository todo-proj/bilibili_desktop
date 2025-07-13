// To parse this JSON data, do
//
//     final userCardModel = userCardModelFromJson(jsonString);

import 'dart:convert';

UserCardModel userCardModelFromJson(String str) => UserCardModel.fromJson(json.decode(str));

String userCardModelToJson(UserCardModel data) => json.encode(data.toJson());

class UserCardModel {
  Card card;
  bool following;
  int archiveCount;
  int articleCount;
  int follower;
  int likeNum;

  UserCardModel({
    required this.card,
    required this.following,
    required this.archiveCount,
    required this.articleCount,
    required this.follower,
    required this.likeNum,
  });

  factory UserCardModel.fromJson(Map<String, dynamic> json) => UserCardModel(
    card: Card.fromJson(json["card"]),
    following: json["following"],
    archiveCount: json["archive_count"],
    articleCount: json["article_count"],
    follower: json["follower"],
    likeNum: json["like_num"],
  );

  Map<String, dynamic> toJson() => {
    "card": card.toJson(),
    "following": following,
    "archive_count": archiveCount,
    "article_count": articleCount,
    "follower": follower,
    "like_num": likeNum,
  };
}

class Card {
  String mid;
  String name;
  bool approve;
  String sex;
  String rank;
  String face;
  String displayRank;
  int regtime;
  int spacesta;
  String birthday;
  String place;
  String description;
  int article;
  List<dynamic> attentions;
  int fans;
  int friend;
  int attention;
  String sign;
  LevelInfo levelInfo;
  Pendant pendant;
  Nameplate nameplate;
  Official official;
  OfficialVerify officialVerify;
  Vip vip;

  Card({
    required this.mid,
    required this.name,
    required this.approve,
    required this.sex,
    required this.rank,
    required this.face,
    required this.displayRank,
    required this.regtime,
    required this.spacesta,
    required this.birthday,
    required this.place,
    required this.description,
    required this.article,
    required this.attentions,
    required this.fans,
    required this.friend,
    required this.attention,
    required this.sign,
    required this.levelInfo,
    required this.pendant,
    required this.nameplate,
    required this.official,
    required this.officialVerify,
    required this.vip,
  });

  factory Card.fromJson(Map<String, dynamic> json) => Card(
    mid: json["mid"],
    name: json["name"],
    approve: json["approve"],
    sex: json["sex"],
    rank: json["rank"],
    face: json["face"],
    displayRank: json["DisplayRank"],
    regtime: json["regtime"],
    spacesta: json["spacesta"],
    birthday: json["birthday"],
    place: json["place"],
    description: json["description"],
    article: json["article"],
    attentions: List<dynamic>.from(json["attentions"].map((x) => x)),
    fans: json["fans"],
    friend: json["friend"],
    attention: json["attention"],
    sign: json["sign"],
    levelInfo: LevelInfo.fromJson(json["level_info"]),
    pendant: Pendant.fromJson(json["pendant"]),
    nameplate: Nameplate.fromJson(json["nameplate"]),
    official: Official.fromJson(json["Official"]),
    officialVerify: OfficialVerify.fromJson(json["official_verify"]),
    vip: Vip.fromJson(json["vip"]),
  );

  Map<String, dynamic> toJson() => {
    "mid": mid,
    "name": name,
    "approve": approve,
    "sex": sex,
    "rank": rank,
    "face": face,
    "DisplayRank": displayRank,
    "regtime": regtime,
    "spacesta": spacesta,
    "birthday": birthday,
    "place": place,
    "description": description,
    "article": article,
    "attentions": List<dynamic>.from(attentions.map((x) => x)),
    "fans": fans,
    "friend": friend,
    "attention": attention,
    "sign": sign,
    "level_info": levelInfo.toJson(),
    "pendant": pendant.toJson(),
    "nameplate": nameplate.toJson(),
    "Official": official.toJson(),
    "official_verify": officialVerify.toJson(),
    "vip": vip.toJson(),
  };
}

class LevelInfo {
  int currentLevel;
  int currentMin;
  int currentExp;
  int nextExp;

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

class Nameplate {
  int nid;
  String name;
  String image;
  String imageSmall;
  String level;
  String condition;

  Nameplate({
    required this.nid,
    required this.name,
    required this.image,
    required this.imageSmall,
    required this.level,
    required this.condition,
  });

  factory Nameplate.fromJson(Map<String, dynamic> json) => Nameplate(
    nid: json["nid"],
    name: json["name"],
    image: json["image"],
    imageSmall: json["image_small"],
    level: json["level"],
    condition: json["condition"],
  );

  Map<String, dynamic> toJson() => {
    "nid": nid,
    "name": name,
    "image": image,
    "image_small": imageSmall,
    "level": level,
    "condition": condition,
  };
}

class Official {
  int role;
  String title;
  String desc;
  int type;

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
  int type;
  String desc;

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
  int pid;
  String name;
  String image;
  int expire;
  String imageEnhance;
  String imageEnhanceFrame;

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
  int type;
  int status;
  int dueDate;
  int vipPayType;
  int themeType;
  Label label;
  int avatarSubscript;
  String nicknameColor;
  int role;
  String avatarSubscriptUrl;
  int vipType;
  int vipStatus;

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
    required this.vipType,
    required this.vipStatus,
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
    vipType: json["vipType"],
    vipStatus: json["vipStatus"],
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
    "vipType": vipType,
    "vipStatus": vipStatus,
  };
}

class Label {
  String path;
  String text;
  String labelTheme;
  String textColor;
  int bgStyle;
  String bgColor;
  String borderColor;

  Label({
    required this.path,
    required this.text,
    required this.labelTheme,
    required this.textColor,
    required this.bgStyle,
    required this.bgColor,
    required this.borderColor,
  });

  factory Label.fromJson(Map<String, dynamic> json) => Label(
    path: json["path"],
    text: json["text"],
    labelTheme: json["label_theme"],
    textColor: json["text_color"],
    bgStyle: json["bg_style"],
    bgColor: json["bg_color"],
    borderColor: json["border_color"],
  );

  Map<String, dynamic> toJson() => {
    "path": path,
    "text": text,
    "label_theme": labelTheme,
    "text_color": textColor,
    "bg_style": bgStyle,
    "bg_color": bgColor,
    "border_color": borderColor,
  };
}
