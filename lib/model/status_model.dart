class Status {
  int? id;
  String? name;
  int? color;

  Map<String, dynamic> statusToMap() {
    var mapping = <String, dynamic>{};
    mapping['id'] = id;
    mapping['name'] = name;
    mapping['color'] = color;

    return mapping;
  }
}
