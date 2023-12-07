import 'package:flutter/material.dart';
import 'package:sample_tree/constant/constant.dart';
import 'package:sample_tree/responsive.dart';

class FollowScreen extends StatelessWidget {
  const FollowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: defaultPadding,
          ),
          Responsive(
            mobile: FollowGridView(
              crossAxisCount: 2,
              childAspectRatio: 1,
            ),
            mobileLarge: FollowGridView(
              crossAxisCount: 2,
            ),
            tablet: FollowGridView(
              childAspectRatio: 1.1,
            ),
            desktop: FollowGridView(
              crossAxisCount: 4,
            ),
          ),
        ],
      ),
    );
  }
}

class FollowGridView extends StatelessWidget {
  const FollowGridView({
    super.key,
    this.crossAxisCount = 3,
    this.childAspectRatio = 1.3,
  });
  final int crossAxisCount;
  final double childAspectRatio;

  static const List<String> contentNames = [
    'Instagram',
    'facebook',
    'Twitter',
    'Linkedln',
  ];

  static const List<String> imageItem = [
    'assets/instagram.png',
    'assets/facebook.png',
    'assets/x.png',
    'assets/linkedln.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: childAspectRatio,
            crossAxisSpacing: defaultPadding / 3,
            mainAxisSpacing: defaultPadding,
          ),
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) =>
              ContainerFollowWidget(
            text1: contentNames[index],
            text2: '',
            imgUrl: imageItem[index],
            onTap: () {},
          ),
        ),
      ),
    );
  }
}

class ContainerFollowWidget extends StatelessWidget {
  final String text1;
  final String text2;
  final String imgUrl;
  final VoidCallback onTap;
  const ContainerFollowWidget({
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
            color: bgColor.withOpacity(0.2),
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
                  child: ClipOval(
                    child: CircleAvatar(
                      backgroundColor: Colors.blue.shade50,
                      radius: 25,
                      child: Responsive.isMobile(context)
                          ? Image.asset(
                              imgUrl,
                              fit: BoxFit.cover,
                            )
                          : Image.network(imgUrl),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  text1,
                  style: Responsive.isDesktop(context)
                      ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold, color: whiteColor)
                      : Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold, color: whiteColor),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
