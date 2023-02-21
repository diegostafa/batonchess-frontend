class UpdateUsernameRequest {
  final String id;
  final String newName;

  UpdateUsernameRequest({required this.id, required this.newName});

  Map<String, dynamic> toJson() => {
        "id": id,
        "newName": newName,
      };
}
