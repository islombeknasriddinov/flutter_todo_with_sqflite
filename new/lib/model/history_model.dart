class SearchHistory{
  String? nameRu;
  String? nameUz;
  String? query;
  String? type;
  int? counter;

  SearchHistory({this.nameUz, this.nameRu, this.query, this.type, this.counter});

  SearchHistory.fromJson(Map<String, dynamic> json)
      : nameRu = json['nameRu'],
        nameUz = json['nameUz'],
        query = json['query'],
        type = json['type'],
        counter = json['counter'];

  Map<String, dynamic> toJson() => {
    'nameRu': nameRu,
    'nameUz': nameUz,
    'query': query,
    'type' : type,
    'counter': counter
  };

  void setCounter(int number){
    counter = number;
  }
}