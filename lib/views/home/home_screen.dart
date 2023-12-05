import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample_tree/constant/constant.dart';
import 'package:sample_tree/responsive.dart';
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
              Responsive.isMobile(context)
                  ? _buildCustomAppBar(context)
                  : _buildCustomAppBar(context),
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
        height: Responsive.isMobile(context)
            ? MediaQuery.of(context).size.height * 0.23
            : MediaQuery.of(context).size.height * 0.23,
        width: Responsive.isMobile(context)
            ? MediaQuery.of(context).size.width * defaultPadding
            : MediaQuery.of(context).size.width * 0.25,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 12, 10, 54),
          borderRadius: BorderRadius.circular(30),
          boxShadow: const [
            BoxShadow(
              spreadRadius: 0,
              blurRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
                    ? Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white)
                    : Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white),
                maxLines: Responsive.isMobileLarge(context) ? 3 : 4,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "Daily News",
                style: Responsive.isDesktop(context)
                    ? Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white)
                    : Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold, color: Colors.white),
                maxLines: Responsive.isMobileLarge(context) ? 2 : 4,
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
                    style: GoogleFonts.robotoSerif(
                      fontSize: 14,
                      color: whiteColor,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Payment",
                    style: GoogleFonts.robotoSerif(
                      fontSize: 14,
                      color: whiteColor,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Review us",
                    style: GoogleFonts.robotoSerif(
                      fontSize: 14,
                      color: whiteColor,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Follow Us",
                    style: GoogleFonts.robotoSerif(
                      fontSize: 14,
                      color: whiteColor,
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
                  MyProjects(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
