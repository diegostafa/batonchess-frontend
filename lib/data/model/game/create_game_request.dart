import 'package:batonchess/data/model/json_object.dart';

class CreateGameRequest extends JsonObject {
  final String creatorId;
  final int maxPlayers;

  CreateGameRequest({required this.creatorId, required this.maxPlayers});

  Map<String, dynamic> toJson() => {
        "creatorId": creatorId,
        "maxPlayers": maxPlayers,
      };
}
