// To parse this JSON data, do
//
//     final searchSuggestModel = searchSuggestModelFromJson(jsonString);

import 'dart:convert';

SearchSuggestModel searchSuggestModelFromJson(String str) => SearchSuggestModel.fromJson(json.decode(str));

String searchSuggestModelToJson(SearchSuggestModel data) => json.encode(data.toJson());

class SearchSuggestModel {
  final List<Tag> tag;

  SearchSuggestModel({
    required this.tag,
  });

  factory SearchSuggestModel.fromJson(Map<String, dynamic> json) => SearchSuggestModel(
    tag: List<Tag>.from(json["tag"].map((x) => Tag.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "tag": List<dynamic>.from(tag.map((x) => x.toJson())),
  };
}

class Tag {
  final String value;
  final String term;
  final int ref;
  final String name;
  final int spid;
  final String type;

  Tag({
    required this.value,
    required this.term,
    required this.ref,
    required this.name,
    required this.spid,
    required this.type,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    value: json["value"],
    term: json["term"],
    ref: json["ref"],
    name: json["name"],
    spid: json["spid"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "term": term,
    "ref": ref,
    "name": name,
    "spid": spid,
    "type": type,
  };
}
