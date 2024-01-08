import 'package:flutter/material.dart';
import 'package:sample_tree/constant/constant.dart';
import 'package:sample_tree/responsive.dart';
import 'package:sample_tree/views/widgets/animated_linear.dart';

class ContainerWidget extends StatelessWidget {
  final String text1;
  final String text2;
  final String imgUrl;
  final int index;
  final VoidCallback onTap;
  const ContainerWidget({
    super.key,
    required this.text1,
    required this.text2,
    required this.imgUrl,
    required this.onTap,
    required this.index,
  });

  static List<Color> colors = [
    Colors.deepPurple,
    Colors.redAccent,
    Colors.pink.shade500,
    Colors.blue,
    Colors.green,
    Colors.teal
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.sizeOf(context).height * defaultPadding,
        width: Responsive.isMobile(context)
            ? MediaQuery.of(context).size.width
            : MediaQuery.sizeOf(context).width * 0.23,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: bgColor,
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 47, 44, 44).withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10),
              child: ClipRRect(
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: Responsive.isMobile(context)
                      ? MediaQuery.of(context).size.width / defaultPadding
                      : MediaQuery.sizeOf(context).width / defaultPadding - 10,
                  child: Responsive.isMobile(context)
                      ? Image.asset(imgUrl)
                      : Image.network(imgUrl),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                text1,
                style: Responsive.isDesktop(context)
                    ? Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(color: whiteColor, letterSpacing: 3)
                    : Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: whiteColor, letterSpacing: 1),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                text2,
                style: Responsive.isDesktop(context)
                    ? Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: whiteColor)
                    : Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: whiteColor.withOpacity(0.4),
                          fontSize: 12,
                        ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: AnimatedLinearProgressIndicator(
                color: colors[index],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
