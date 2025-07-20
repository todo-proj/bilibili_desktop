
enum SubWindowType {
  video,
  live;

  static SubWindowType fromString(String value) {
    return SubWindowType.values.firstWhere((element) => element.name == value);
  }
}