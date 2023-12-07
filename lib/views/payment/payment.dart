import 'package:flutter/material.dart';
import 'package:sample_tree/constant/constant.dart';
import 'package:sample_tree/responsive.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

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
            mobile: PaymentsGridView(
              crossAxisCount: 2,
              childAspectRatio: 1,
            ),
            mobileLarge: PaymentsGridView(
              crossAxisCount: 2,
            ),
            tablet: PaymentsGridView(
              childAspectRatio: 1.1,
            ),
            desktop: PaymentsGridView(
              crossAxisCount: 4,
            ),
          ),
        ],
      ),
    );
  }
}

class PaymentsGridView extends StatelessWidget {
  final TabController? tabController;
  const PaymentsGridView({
    super.key,
    this.crossAxisCount = 3,
    this.childAspectRatio = 1.3,
    this.tabController,
  });
  final int crossAxisCount;
  final double childAspectRatio;

  static const List<String> contentNames = [
    'RazorPay',
    'GooglePay',
    'PhonePay',
    'Paypal',
  ];

  static const List<String> imagesItems = [
    'assets/razorpay.png',
    'assets/gpay.png',
    'assets/phonepe.png',
    'assets/paypal.png',
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
              PaymentContainerWidget(
            text1: contentNames[index],
            imgUrl: imagesItems[index],
            onTap: () {},
          ),
        ),
      ),
    );
  }
}

class PaymentContainerWidget extends StatelessWidget {
  final String text1;

  final String imgUrl;
  final VoidCallback onTap;
  const PaymentContainerWidget({
    super.key,
    required this.text1,
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
                ClipOval(
                  child: CircleAvatar(
                    backgroundColor: whiteColor,
                    radius: 25,
                    child: Responsive.isMobile(context)
                        ? Image.asset(
                            imgUrl,
                            fit: BoxFit.cover,
                          )
                        : Image.network(
                            imgUrl,
                            fit: BoxFit.fill,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
