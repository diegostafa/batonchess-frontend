import "package:batonchess/data/model/user/user_player.dart";
import "package:flutter/material.dart";

class PlayerCardBc extends StatelessWidget {
  final void Function()? onTap;
  final UserPlayer player;

  const PlayerCardBc({
    super.key,
    required this.onTap,
    required this.player,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: player.playingAsWhite ? Colors.white : Colors.black,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: const Icon(Icons.album),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Player: ${player.name}"),
              ],
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (player.playingAsWhite) const Text("White team") else const Text("Black team")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
