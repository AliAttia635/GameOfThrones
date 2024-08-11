class Quote {
  late String name;
  late List<dynamic> quotes;

  Quote({
    required this.name,
    required this.quotes,
  });

  Quote.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quotes = json['quotes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['quotes'] = this.quotes;
    return data;
  }
}
