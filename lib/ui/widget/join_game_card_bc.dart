import "package:batonchess/data/model/game/game_info.dart";
import "package:batonchess/utils/prettify_utils.dart";
import "package:flutter/material.dart";

class JoinGameCardBc extends StatelessWidget {
  final void Function()? onTap;
  final GameInfo gameInfo;

  const JoinGameCardBc({
    super.key,
    this.onTap,
    required this.gameInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: const Icon(Icons.games),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Creator: ${gameInfo.creatorName}"),
                    Text("#${prettyId(gameInfo.creatorId)}"),
                  ],
                ),
              ],
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text("Started on ${prettyTime(gameInfo.createdAt)}"),
                ),
                Flexible(
                  child: Text(
                    "${gameInfo.currentPlayers}/${gameInfo.maxPlayers * 2} currently playing",
                    style: gameInfo.currentPlayers == 0
                        ? const TextStyle(color: Colors.red)
                        : const TextStyle(color: Colors.green),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
