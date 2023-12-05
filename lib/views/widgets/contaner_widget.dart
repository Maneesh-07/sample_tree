import 'package:flutter/material.dart';
import 'package:sample_tree/constant/constant.dart';
import 'package:sample_tree/responsive.dart';

class ContainerWidget extends StatelessWidget {
  final String text1;
  final String text2;
  final String imgUrl;
  final VoidCallback onTap;
  const ContainerWidget({
    super.key,
    required this.text1,
    required this.text2,
    required this.imgUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: MediaQuery.of(context).size.height / 2,
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: CircleAvatar(
                    backgroundColor: Colors.blue.shade50,
                    radius: 20,
                    child: Responsive.isMobile(context)
                        ? Image.asset(imgUrl)
                        : Image.network(imgUrl),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  text1,
                  style: Responsive.isDesktop(context)
                      ? Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold, color: whiteColor)
                      : Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold, color: whiteColor),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  text2,
                  style: Responsive.isDesktop(context)
                      ? Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w100, color: whiteColor)
                      : Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w300, color: whiteColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
