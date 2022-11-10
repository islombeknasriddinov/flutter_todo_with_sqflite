class SearchHistory{
  String? nameRu;
  String? nameUz;
  String? query;
  String? type;

  SearchHistory({this.nameUz, this.nameRu, this.query, this.type});

  SearchHistory.fromJson(Map<String, dynamic> json)
      : nameRu = json['nameRu'],
        nameUz = json['nameUz'],
        query = json['query'],
        type = json['type'];

  Map<String, dynamic> toJson() => {
    'nameRu': nameRu,
    'nameUz': nameUz,
    'query': query,
    'type' : type,
  };
}