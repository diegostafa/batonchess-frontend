import 'package:batonchess/data/model/game_state.dart';
import 'package:flutter/material.dart';

class JoinGameCardBc extends StatelessWidget {
  final void Function()? onTap;
  final GameState gs;

  const JoinGameCardBc({
    super.key,
    this.onTap,
    required this.gs,
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
            title: Text(gs.gameId.toString()),
            subtitle: Text(gs.props.maxPlayers.toString()),
          ),
        ),
      ),
    );
  }
}
