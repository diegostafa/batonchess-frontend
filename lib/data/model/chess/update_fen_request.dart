import "package:batonchess/data/model/json_object.dart";

class UpdateFenRequest extends JsonObject {
  final int gameId;
  final String userId;
  final String newFen;

  UpdateFenRequest({
    required this.gameId,
    required this.userId,
    required this.newFen,
  });

  @override
  Map<String, dynamic> toJson() =>
      {"gameId": gameId, "userId": userId, "newFen": newFen};
}
