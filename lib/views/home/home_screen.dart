import 'package:flutter/material.dart';
import 'package:sample_tree/constant/constant.dart';
import 'package:sample_tree/responsive.dart';
import 'package:sample_tree/views/follow_us/follow_us.dart';
import 'package:sample_tree/views/payment/payment.dart';
import 'package:sample_tree/views/review/review_us.dart';
import 'package:sample_tree/views/widgets/myproject.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!Responsive.isMobileLarge(context))
                const SizedBox(
                  height: defaultPadding / 2,
                ),
              _buildCustomAppBar(context),
              const SizedBox(
                height: defaultPadding,
              ),
              // Responsive.isDesktop(context)
              //     ? _buildCustomAppBar(context)
              //     : _buildCustomAppBar(context),
              _buildTabBarView(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.only(top: defaultPadding),
        height: Responsive.isDesktop(context)
            ? MediaQuery.of(context).size.height * 0.23
            : MediaQuery.of(context).size.height * 0.25,
        width: Responsive.isMobile(context) || Responsive.isTablet(context)
            ? MediaQuery.of(context).size.width * defaultPadding
            : MediaQuery.of(context).size.width * 0.50,
        decoration: BoxDecoration(
          color: bgColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 47, 44, 44).withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 10,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Welcome!",
                        style: Responsive.isDesktop(context)
                            ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                                color: Colors.white)
                            : Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 2),
                        maxLines: Responsive.isMobileLarge(context) ? 3 : 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Daily News",
                        style: Responsive.isDesktop(context)
                            ? Theme.of(context).textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1)
                            : Theme.of(context).textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1),
                        maxLines: Responsive.isMobileLarge(context) ? 2 : 4,
                      ),
                    ],
                  ),
                  ClipOval(
                    child: Container(
                      height: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.height * 0.10
                          : MediaQuery.sizeOf(context).height * 0.18,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width * 0.10
                          : MediaQuery.sizeOf(context).width * 0.35,
                      decoration: BoxDecoration(
                        color: darkColor,
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 47, 44, 44)
                                .withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBarView(BuildContext context) {
    return Expanded(
      child: DefaultTabController(
        length: 4,
        child: Column(
          children: [
            const SizedBox(height: 8),
            TabBar(
              tabs: [
                Tab(
                  child: Text(
                    "Home",
                    style: Responsive.isDesktop(context)
                        ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: whiteColor,
                            letterSpacing: 1)
                        : Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: whiteColor,
                            letterSpacing: 1),
                  ),
                ),
                Tab(
                  child: Text(
                    "Payment",
                    style: Responsive.isDesktop(context)
                        ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: whiteColor,
                              letterSpacing: 1,
                            )
                        : Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: whiteColor,
                            letterSpacing: 1),
                  ),
                ),
                Tab(
                  child: Text(
                    "Review us",
                    style: Responsive.isDesktop(context)
                        ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: whiteColor,
                              letterSpacing: 1,
                            )
                        : Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: whiteColor,
                              letterSpacing: 0.5,
                            ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Follow Us",
                    style: Responsive.isDesktop(context)
                        ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold, color: whiteColor,letterSpacing: 1)
                        : Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: whiteColor,
                              letterSpacing: 0.5,
                            ),
                  ),
                ),
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  MyProjects(),
                  PaymentScreen(),
                  ReviewScreen(),
                  FollowScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
