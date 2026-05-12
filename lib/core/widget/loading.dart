import 'package:flutter/material.dart';
import 'package:flutter_template/gen/assets.gen.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Loading(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Assets.animations.loading.lottie(width: 300));
  }
}
