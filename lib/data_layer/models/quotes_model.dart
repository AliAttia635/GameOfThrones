class Quote {
  late String name;
  late String slug;
  late House house;
  late List<String> quotes;

  Quote(
      {required this.name,
      required this.slug,
      required this.house,
      required this.quotes});

  Quote.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    slug = json['slug'];
    house = json['house'];
    quotes = json['quotes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['slug'] = this.slug;
    if (this.house != null) {
      data['house'] = this.house!.toJson();
    }
    data['quotes'] = this.quotes;
    return data;
  }
}

class House {
  String? slug;
  String? name;

  House({this.slug, this.name});

  House.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slug'] = this.slug;
    data['name'] = this.name;
    return data;
  }
}
