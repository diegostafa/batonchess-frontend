class CreateGameRequest {
  final String creatorId;
  final int maxPlayers;

  CreateGameRequest({required this.creatorId, required this.maxPlayers});

  Map<String, dynamic> toJson() => {
        "creatorId": creatorId,
        "maxPlayers": maxPlayers,
      };
}
