import "package:batonchess/data/model/json_object.dart";

class BatonchessTcpAction {
  final String actionType;
  final JsonObject actionBody;

  BatonchessTcpAction({required this.actionType, required this.actionBody});

  Map<String, dynamic> toJson() =>
      {"actionType": actionType, "actionBody": actionBody.toJson()};
}
