class Pokemon {
  Pokemon({
    this.results
  });

  final List<dynamic> results;


  factory Pokemon.fromJson(Map<String, dynamic> json) {
    return Pokemon(
        results: json['results'],);
  }

}
