
class Todo {
  int? id;
  String? title;
  String? description;
  int? color;
  int? statusId;

  Map<String, dynamic> todoToMap() {
    var mapping = <String, dynamic>{};
    mapping['id'] = id;
    mapping['title'] = title;
    mapping['description'] = description;
    mapping['statusId'] = statusId;

    return mapping;
  }
}
