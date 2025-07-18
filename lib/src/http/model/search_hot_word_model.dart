// To parse this JSON data, do
//
//     final searchHotWordModel = searchHotWordModelFromJson(jsonString);

import 'dart:convert';

SearchHotWordModel searchHotWordModelFromJson(String str) => SearchHotWordModel.fromJson(json.decode(str));

String searchHotWordModelToJson(SearchHotWordModel data) => json.encode(data.toJson());

class SearchHotWordModel {
  final Trending trending;

  SearchHotWordModel({
    required this.trending,
  });

  factory SearchHotWordModel.fromJson(Map<String, dynamic> json) => SearchHotWordModel(
    trending: Trending.fromJson(json["trending"]),
  );

  Map<String, dynamic> toJson() => {
    "trending": trending.toJson(),
  };
}

class Trending {
  final String title;
  final String trackid;
  final List<ListElement> list;

  Trending({
    required this.title,
    required this.trackid,
    required this.list,
  });

  factory Trending.fromJson(Map<String, dynamic> json) => Trending(
    title: json["title"],
    trackid: json["trackid"],
    list: List<ListElement>.from(json["list"].map((x) => ListElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "trackid": trackid,
    "list": List<dynamic>.from(list.map((x) => x.toJson())),
  };
}

class ListElement {
  final String keyword;
  final String showName;
  final String icon;
  final String uri;
  final String goto;

  ListElement({
    required this.keyword,
    required this.showName,
    required this.icon,
    required this.uri,
    required this.goto,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
    keyword: json["keyword"],
    showName: json["show_name"],
    icon: json["icon"],
    uri: json["uri"],
    goto: json["goto"],
  );

  Map<String, dynamic> toJson() => {
    "keyword": keyword,
    "show_name": showName,
    "icon": icon,
    "uri": uri,
    "goto": goto,
  };
}
