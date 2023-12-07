import 'package:flutter/material.dart';
import 'package:sample_tree/constant/constant.dart';
import 'package:sample_tree/responsive.dart';

class FiveStar extends StatelessWidget {
  const FiveStar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: scaffoldBgColor,
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: defaultPadding,
          ),
          Responsive(
            mobile: ReviewGridView(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
            ),
            mobileLarge: ReviewGridView(
              crossAxisCount: 2,
            ),
            tablet: ReviewGridView(
              childAspectRatio: 1.1,
            ),
            desktop: ReviewGridView(
              crossAxisCount: 4,
            ),
          ),
        ],
      ),
    );
  }
}

class ReviewGridView extends StatelessWidget {
  const ReviewGridView({
    super.key,
    this.crossAxisCount = 3,
    this.childAspectRatio = 1.3,
  });
  final int crossAxisCount;
  final double childAspectRatio;

  static const List<String> contentNames = [
    'Google',
    'Trip Advisor',
    'Booking.com',
    'Airbnb',
  ];

  static const List<String> imagesContent = [
    'assets/google.png',
    'assets/tripadvisor.png',
    'assets/booking_com.png',
    'assets/airbnb.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: childAspectRatio,
                crossAxisSpacing: defaultPadding / 5,
                mainAxisSpacing: defaultPadding / 5,
              ),
              itemCount: contentNames.length,
              itemBuilder: (BuildContext context, int index) =>
                  FiveStarContainer(
                text1: contentNames[index],
                imgUrl: imagesContent[index],
                onTap: () {},
              ),
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  fixedSize: const Size(70, 0),
                  foregroundColor: whiteColor,
                  backgroundColor: kButtonColorBlue,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Submit'))
          ],
        ),
      ),
    );
  }
}

class FiveStarContainer extends StatelessWidget {
  final String text1;

  final String imgUrl;
  final VoidCallback onTap;
  const FiveStarContainer({
    super.key,
    required this.text1,
    required this.imgUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: Responsive.isMobile(context)
              ? MediaQuery.of(context).size.width
              : MediaQuery.sizeOf(context).width * 0.23,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: bgColor.withOpacity(0.190),
            image: DecorationImage(
              image: AssetImage(imgUrl),
              scale: 13,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 47, 44, 44).withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  text1,
                  style: Responsive.isDesktop(context)
                      ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.bold, color: whiteColor)
                      : Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold, color: whiteColor),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
