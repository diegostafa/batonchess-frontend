import "package:batonchess/data/model/user/user_player.dart";
import "package:batonchess/utils/prettify_utils.dart";
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
      elevation: 6,
      color:
          player.playingAsWhite ? Colors.white : Theme.of(context).primaryColor,
      child: InkWell(
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
                Text("Joined: ${prettyTime(player.joinedAt)}")
              ],
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: Text("#${prettyId(player.id)}")),
                Flexible(
                  child: Text(
                    player.playingAsWhite ? "White team" : "Black team",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
