class Categories {
  final List<String> categories;

  factory Categories.fromJson(List<dynamic> json) {
    var x = <String>[];
    var c = json.forEach(
      (element) => x.add(
        element["name"],
      ),
    );
    return Categories(x);
  }
  Categories(this.categories);
}
