import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sample_tree/constant/constant.dart';
import 'package:sample_tree/model/fetch_companies.dart';
import 'package:sample_tree/responsive.dart';
import 'package:sample_tree/services/get_company_data.dart';
import 'package:sample_tree/views/follow_us/follow_us.dart';
import 'package:sample_tree/views/payment/payment.dart';
import 'package:sample_tree/views/review/review_us.dart';
import 'package:sample_tree/views/widgets/myproject.dart';

class CategoryCard extends StatefulWidget {
  const CategoryCard({super.key});

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  late ApiServicesForCompaniesDetails apiServicesForCompaniesDetails;
  int selectedTabIndex = 0;
  @override
  void initState() {
    super.initState();
    apiServicesForCompaniesDetails = ApiServicesForCompaniesDetails();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: mHeight!,
      child: Stack(
        children: [
          Container(
            height: mHeight!,
            decoration: const BoxDecoration(
              gradient: scaffoldGradient,
            ),
          ),
          Positioned(
              top: 0,
              left: mWidth! / 65,
              right: mHeight! / 65,
              bottom: 0,
              // child: Container(
              //   height: mHeight! / 5.2,
              //   width: mWidth! / 1.07,
              //   decoration: BoxDecoration(
              //       color: scaffoldBgColor,
              //       borderRadius: BorderRadius.circular(20),
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.grey.withOpacity(0.5),
              //           spreadRadius: 2,
              //           blurRadius: 5,
              //           offset: const Offset(3, 4),
              //         ),
              //       ]),
              child: FutureBuilder<List<FetchCompanies>>(
                  future: apiServicesForCompaniesDetails.fetchCompanies(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text("No Products Available");
                    }

                    final details = snapshot.data;

                    return Column(
                      children: [
                        // SizedBox(
                        //   height: mHeight! / 7.7,
                        //   child: GridView.builder(
                        //     gridDelegate:
                        //         const SliverGridDelegateWithFixedCrossAxisCount(
                        //       crossAxisCount: 1,
                        //       crossAxisSpacing: 1,
                        //       mainAxisSpacing: 0,
                        //     ),
                        //     shrinkWrap: true,
                        //     scrollDirection: Axis.horizontal,
                        //     itemCount: 4,
                        //     itemBuilder: (BuildContext context, int index) {
                        //       return const SizedBox.shrink();
                        //     },
                        //   ),
                        // ),

                        if (Responsive.isMobile(context) ||
                            Responsive.isMobileLarge(context) ||
                            Responsive.isDesktop(context) ||
                            Responsive.isTablet(context))
                          // const SizedBox(
                          //   height: defaultPadding / 2,
                          // ),
                          _buildCustomAppBar(context, details),

                        // const SizedBox(
                        //   height: defaultPadding,
                        // ),
                        // Responsive.isDesktop(context)
                        //     ? _buildCustomAppBar(context)
                        //     : _buildCustomAppBar(context),
                        if (!Responsive.isMobile(context))
                          _buildTabBarView(context),
                        if (Responsive.isMobile(context))
                          _buildTabBarView(context)

                        // Container(
                        //   height: mHeight! / 22,
                        //   width: mWidth! / 1.2,
                        //   decoration: BoxDecoration(
                        //     color: whiteColor,
                        //     borderRadius: BorderRadius.circular(14),
                        //   ),
                        //   child: const Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Text(
                        //           'All categories',
                        //           style: TextStyle(
                        //             color: bgColor,
                        //             fontSize: 16,
                        //             fontWeight: FontWeight.w500,
                        //           ),
                        //         )
                        //       ]),
                        // )
                      ],
                    );
                  })),
        ],
      ),
    );
  }

  Widget _buildCustomAppBar(
    BuildContext context,
    List<FetchCompanies>? details,
  ) {
    final company = details![selectedTabIndex];
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Container(
        padding: const EdgeInsets.only(top: defaultPadding),
        height: Responsive.isDesktop(context)
            ? MediaQuery.of(context).size.height * 0.23
            : MediaQuery.of(context).size.height / defaultPadding + 140,
        width: Responsive.isMobile(context) || Responsive.isTablet(context)
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: bgColor,
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
          padding: const EdgeInsets.only(left: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipOval(
                            child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 20,
                              child: Responsive.isMobile(context)
                                  ? Image.asset('assets/Animation3.gif')
                                  : Image.network('assets/Animation3.gif'),
                            ),
                          ),
                          SizedBox(
                            width: Responsive.isMobile(context)
                                ? MediaQuery.sizeOf(context).width / 1.9
                                : MediaQuery.sizeOf(context).width / 1.5,
                          ),
                          CircleAvatar(
                            child: SizedBox(
                              height: Responsive.isDesktop(context) &&
                                      Responsive.isMobile(context)
                                  ? MediaQuery.of(context).size.height * 0.4
                                  : MediaQuery.sizeOf(context).height * 0.06,
                              width: Responsive.isDesktop(context)
                                  ? MediaQuery.of(context).size.width * 0.1
                                  : MediaQuery.sizeOf(context).width * 0.15,
                              child: CachedNetworkImage(
                                  color: bgColor,
                                  imageUrl:
                                      'https://admin.scanetapp.com/storage/app/public/${company.logo}',
                                  fit: BoxFit.fitHeight,
                                  imageBuilder: (context, imageProvider) =>
                                      Padding(
                                        padding: const EdgeInsets.only(left: 0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: double.maxFinite,
                                            decoration: BoxDecoration(
                                                color: bgColor,
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.fill)),
                                          ),
                                        ),
                                      ),
                                  progressIndicatorBuilder: (context, url,
                                          downloadProgress) =>
                                      Padding(
                                        padding: const EdgeInsets.only(left: 0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: double.maxFinite,
                                            decoration: const BoxDecoration(
                                              color: whiteColor,
                                            ),
                                            child:
                                                const CupertinoActivityIndicator(),
                                          ),
                                        ),
                                      ),
                                  errorWidget: (context, url, error) => Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0, right: 0, bottom: 0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: double.maxFinite,
                                            decoration: const BoxDecoration(
                                              color: bgColor,
                                            ),
                                            child: Icon(
                                              Icons.error,
                                              color:
                                                  whiteColor.withOpacity(0.9),
                                            ),
                                          ),
                                        ),
                                      )),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Welcome!",
                        style: Responsive.isDesktop(context)
                            ? Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(letterSpacing: 2, color: Colors.white)
                            : Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: Colors.white, letterSpacing: 2),
                        maxLines: Responsive.isMobileLarge(context) ? 3 : 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Text(
                            company.name,
                            style: Responsive.isDesktop(context)
                                ? Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                        color: Colors.white, letterSpacing: 1)
                                : Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Colors.white,
                                        fontFamily: 'arial',
                                        letterSpacing: 1),
                            maxLines: Responsive.isMobileLarge(context) ? 1 : 3,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          CircleAvatar(
                            radius: 13,
                            child: SizedBox(
                              height: Responsive.isDesktop(context)
                                  ? MediaQuery.of(context).size.height * 0.1
                                  : MediaQuery.sizeOf(context).height * 0.04,
                              width: Responsive.isDesktop(context)
                                  ? MediaQuery.of(context).size.width * 0.1
                                  : MediaQuery.sizeOf(context).width * 0.07,
                              child: CachedNetworkImage(
                                  color: bgColor,
                                  imageUrl:
                                      'https://admin.scanetapp.com/storage/app/public/${company.logo}',
                                  fit: BoxFit.fitHeight,
                                  imageBuilder: (context, imageProvider) =>
                                      Padding(
                                        padding: const EdgeInsets.only(left: 0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: double.maxFinite,
                                            decoration: BoxDecoration(
                                                color: bgColor,
                                                image: DecorationImage(
                                                    image: imageProvider,
                                                    fit: BoxFit.fill)),
                                          ),
                                        ),
                                      ),
                                  progressIndicatorBuilder: (context, url,
                                          downloadProgress) =>
                                      Padding(
                                        padding: const EdgeInsets.only(left: 0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: double.maxFinite,
                                            decoration: const BoxDecoration(
                                              color: whiteColor,
                                            ),
                                            child:
                                                const CupertinoActivityIndicator(),
                                          ),
                                        ),
                                      ),
                                  errorWidget: (context, url, error) => Padding(
                                        padding: const EdgeInsets.only(
                                            left: 0, right: 0, bottom: 0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: double.maxFinite,
                                            decoration: const BoxDecoration(
                                              color: bgColor,
                                            ),
                                            child: Icon(
                                              Icons.error,
                                              color:
                                                  whiteColor.withOpacity(0.9),
                                            ),
                                          ),
                                        ),
                                      )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
                              color: whiteColor,
                            )
                        : Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: whiteColor,
                            ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Payment",
                    style: Responsive.isDesktop(context)
                        ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: whiteColor,
                            )
                        : Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: whiteColor,
                            ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Review us",
                    style: Responsive.isDesktop(context)
                        ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: whiteColor,
                            )
                        : Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: whiteColor,
                            ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Follow Us",
                    style: Responsive.isDesktop(context)
                        ? Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: whiteColor,
                            )
                        : Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontFamily: 'arial',
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
