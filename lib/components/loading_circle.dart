import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class LoadingCircle extends StatelessWidget {
  final double size;

  const LoadingCircle({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //1
    return SizedBox(
      width: size,
      height: size,
      //2
      child: const FlareActor(
        'assets/animations/loading_circle.flr',
        animation: 'load',
        snapToEnd: true,
      ),
    );
  }
}
