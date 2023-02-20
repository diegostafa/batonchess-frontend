class User {
  String id;
  String name;
  User({required this.id, required this.name});

  String prettyId() {
    return id.substring(0, 8).toUpperCase();
  }

  factory User.fromJson(Map<String, dynamic> json) =>
      User(id: json['id'] as String, name: json['name'] as String);
}
