import "package:batonchess/data/model/user/user_player.dart";
import "package:flutter/material.dart";

class PlayerCardBc extends StatelessWidget {
  final void Function()? onTap;
  final UserPlayer player;
  final bool isCurrentTurn;

  const PlayerCardBc({
    super.key,
    required this.onTap,
    required this.player,
    required this.isCurrentTurn,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      color:
          player.playingAsWhite ? Colors.white : Theme.of(context).primaryColor,
      child: InkWell(
        onTap: null,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            textColor: player.playingAsWhite ? Colors.black : Colors.white,
            leading: Icon(
              Icons.face,
              color: player.playingAsWhite
                  ? Theme.of(context).primaryColor
                  : Colors.white,
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Player: ${player.name}"),
              ],
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (player.playingAsWhite)
                  const Text("White team")
                else
                  const Text("Black team")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
