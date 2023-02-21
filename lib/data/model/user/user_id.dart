class UserId {
  final String id;

  UserId({required this.id});

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        id: json["id"] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
