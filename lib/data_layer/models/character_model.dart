class Character {
  late int id;
  late String firstName;
  String? lastName;
  late String fullName;
  String? title;
  String? family;
  late String image;
  late String imageUrl;

  Character(
      {required this.id,
      required this.firstName,
      this.lastName,
      required this.fullName,
      this.title,
      this.family,
      required this.image,
      required this.imageUrl});

  Character.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    fullName = json['fullName'];
    title = json['title'];
    family = json['family'];
    image = json['image'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['fullName'] = this.fullName;
    data['title'] = this.title;
    data['family'] = this.family;
    data['image'] = this.image;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
