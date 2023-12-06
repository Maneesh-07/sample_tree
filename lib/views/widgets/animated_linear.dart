import 'package:flutter/material.dart';
import 'package:sample_tree/constant/constant.dart';
import 'package:sample_tree/responsive.dart';

class AnimatedLinearProgressIndicator extends StatelessWidget {
  final Color color;
  const AnimatedLinearProgressIndicator({
    super.key,
    required this.label, required this.color,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: defaultPadding),
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 0.50),
        duration: defaultDuration,
        builder: (context, double value, child) => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  label,
                  style: Responsive.isDesktop(context)
                      ? Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w300, color: whiteColor)
                      : Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w200,
                          color: whiteColor,
                          fontSize: 10),
                ),
              ],
            ),
            const SizedBox(
              height: defaultPadding / 2,
            ),
            LinearProgressIndicator(
              value: value,
              color: color,
              backgroundColor: darkColor,
            ),
          ],
        ),
      ),
    );
  }
}
