import 'package:flutter/material.dart';

class JoinGameCardBc extends StatelessWidget {
  final void Function()? onTap;

  const JoinGameCardBc({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: ListTile(
            leading: Icon(Icons.album),
            title: Text('title'),
            subtitle: Text('subtitle'),
          ),
        ),
      ),
    );
  }
}
