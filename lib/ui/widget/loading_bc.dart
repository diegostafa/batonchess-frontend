import "package:flutter/material.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";

class LoadingBc extends StatelessWidget {
  final String msg;
  const LoadingBc({super.key, this.msg = ""});

  @override
  Widget build(BuildContext context) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpinKitCubeGrid(
          size: 100,
          color: Theme.of(context).primaryColor,
        ),
        Text(msg)
      ],
    );
}
