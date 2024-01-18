import 'package:flutter/material.dart';
import 'package:sample_tree/constant/constant.dart';
import 'package:sample_tree/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

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
            Padding(
              padding: const EdgeInsets.fromLTRB(70, 0, 70, 0),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  childAspectRatio: childAspectRatio / 1.5,
                  crossAxisSpacing: defaultPadding - 8,
                  mainAxisSpacing: defaultPadding - 8,
                ),
                itemCount: contentNames.length,
                itemBuilder: (BuildContext context, int index) =>
                    FiveStarContainer(
                  text1: contentNames[index],
                  imgUrl: imagesContent[index],
                  onTap: () {
                    _navigateToNextPage(context, index);
                  },
                ),
              ),
            ),
            const SizedBox(
              height: defaultPadding,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Can not Lunch url";
    }
  }

  void _navigateToNextPage(BuildContext context, int index) {
    // TabController tabController = DefaultTabController.of(context);

    if (contentNames[index] == 'Google') {
      _launchUrl(
          'https://www.google.com/search?gs_ssp=eJzj4tVP1zc0zM2ILyqvLMo1YLRSNagwTjIwTbJMSjSwTDM0TDMwtTKoMDdMSbRMTE5LTjYwNzA2tPBiT8_JT8pMqwQAWCMS6A&q=globify&rlz=1C1UEAD_enIN1078IN1078&oq=glo&gs_lcrp=EgZjaHJvbWUqFQgBEC4YJxivARjHARiABBiKBRiOBTIGCAAQRRg5MhUIARAuGCcYrwEYxwEYgAQYigUYjgUyBggCEEUYPTIGCAMQRRhBMgYIBBBFGEEyBggFEEUYQTIGCAYQRRg9MgYIBxBFGD3SAQg0NjYzajBqN6gCALACAA&sourceid=chrome&ie=UTF-8#ip=1&lrd=0x3b05b9ba09f11f05:0x71da9acfcc070318,1,,,,');
    } else if (contentNames[index] == 'facebook') { 
      _launchUrl('https://www.facebook.com/Devastanam');
    } else if (contentNames[index] == 'Twitter') {
      _launchUrl('');
    } else if (contentNames[index] == 'Linkedln') {
      _launchUrl(
          'https://www.linkedin.com/company/globify-software-solutions-pvt-ltd/');
    }
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: Responsive.isMobile(context)
            ? MediaQuery.of(context).size.width
            : MediaQuery.sizeOf(context).width * 0.23,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(20),
          color: bgColor,
          // image: DecorationImage(
          //   image: AssetImage(imgUrl,),
          //   scale: 10,
          // ),
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
          children: [
            const SizedBox(
              height: 20,
            ),
            ClipOval(
              child: Image.asset(
                imgUrl,
                height: 55,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    text1,
                    style: Responsive.isDesktop(context)
                        ? Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: whiteColor)
                        : Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: whiteColor),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
