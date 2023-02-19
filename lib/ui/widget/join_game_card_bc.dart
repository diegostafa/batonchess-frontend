import 'package:batonchess/data/model/game_info.dart';
import 'package:flutter/material.dart';

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
            leading: const Icon(Icons.album),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Creator: ${gameInfo.creatorName}"),
                Text("Started: ${gameInfo.createdAt}"),
              ],
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                    "${gameInfo.currentPlayers}/${gameInfo.maxPlayers} currently playing",),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
