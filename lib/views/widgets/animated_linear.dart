import 'package:flutter/material.dart';
import 'package:sample_tree/constant/constant.dart';

class AnimatedLinearProgressIndicator extends StatelessWidget {
  final Color color;
  const AnimatedLinearProgressIndicator({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding),
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 0.50),
        duration: defaultDuration,
        builder: (context, double value, child) => Column(
          children: [
            const SizedBox(
              height: defaultPadding / 2,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: LinearProgressIndicator(
                value: value,
                color: color,
                backgroundColor: darkColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
