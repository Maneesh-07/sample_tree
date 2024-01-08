import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample_tree/constant/constant.dart';
import 'package:sample_tree/model/get_user_id_model.dart';
import 'package:sample_tree/responsive.dart';
import 'package:sample_tree/services/get_company_id.dart';
import 'package:url_launcher/url_launcher.dart';

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

class FollowGridView extends StatefulWidget {
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
  State<FollowGridView> createState() => _FollowGridViewState();
}

class _FollowGridViewState extends State<FollowGridView> {
  late ApiServicesForLinkLabel apiServicesForCompaniesDetails;

  @override
  void initState() {
    super.initState();
    apiServicesForCompaniesDetails = ApiServicesForLinkLabel();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: FutureBuilder<List<GetCompanies>>(
              future: apiServicesForCompaniesDetails.fetchDetails(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text("No Products Available");
                }

                final details = snapshot.data;

                return GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget.crossAxisCount,
                    childAspectRatio: widget.childAspectRatio * 0.9,
                    crossAxisSpacing: defaultPadding,
                    mainAxisSpacing: defaultPadding,
                  ),
                  itemCount: details!.length,
                  itemBuilder: (BuildContext context, int index) =>
                      ContainerFollowWidget(
                    details: details[index],
                    text2: '',
                    index: index,
                    onTap: () {
                      // _navigateToNextPage(context, index);
                    },
                  ),
                );
              }),
        ),
      ),
    );
  }

  // Future<void> _launchUrl(String url) async {
  //   final Uri uri = Uri.parse(url);
  //   if (!await launchUrl(
  //     uri,
  //     mode: LaunchMode.externalApplication,
  //   )) {
  //     throw "Can not Lunch url";
  //   }
  // }

  // void _navigateToNextPage(BuildContext context, int index) {
  //   // TabController tabController = DefaultTabController.of(context);

  //   if (FollowGridView.contentNames[index] == 'Instagram') {
  //     _launchUrl('https://www.instagram.com/globify_digital_solutions');
  //   } else if (FollowGridView.contentNames[index] == 'facebook') {
  //     _launchUrl('https://www.facebook.com/globifydigital');
  //   } else if (FollowGridView.contentNames[index] == 'Twitter') {
  //     _launchUrl('');
  //   } else if (FollowGridView.contentNames[index] == 'Linkedln') {
  //     _launchUrl(
  //         'https://www.linkedin.com/company/globify-software-solutions-pvt-ltd/');
  //   }
  // }
}

class ContainerFollowWidget extends StatelessWidget {
  final GetCompanies details;
  final String? text2;
  final String? imgUrl;
  final VoidCallback? onTap;
  final int index;
  const ContainerFollowWidget({
    super.key,
    required this.details,
    this.text2,
    this.imgUrl,
    required this.index,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _navigateToNextPage(context, index);
      },
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: ClipRRect(
                    child: CircleAvatar(
                      radius: 25,
                      child: Responsive.isMobile(context)
                          ? CachedNetworkImage(
                              color: bgColor,
                              imageUrl: details.icon,
                              imageBuilder: (context, imageProvider) => Padding(
                                    padding: const EdgeInsets.only(left: 0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
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
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
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
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: double.maxFinite,
                                        decoration: const BoxDecoration(
                                          color: bgColor,
                                        ),
                                        child: Icon(
                                          Icons.error,
                                          color: whiteColor.withOpacity(0.9),
                                        ),
                                      ),
                                    ),
                                  ))
                          : CachedNetworkImage(
                              color: bgColor,
                              imageUrl: details.icon,
                              imageBuilder: (context, imageProvider) => Padding(
                                    padding: const EdgeInsets.only(left: 0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
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
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
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
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: double.maxFinite,
                                        decoration: const BoxDecoration(
                                          color: bgColor,
                                        ),
                                        child: Icon(
                                          Icons.error,
                                          color: whiteColor.withOpacity(0.9),
                                        ),
                                      ),
                                    ),
                                  )),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  details.label,
                  style: Responsive.isDesktop(context)
                      ? Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: whiteColor,
                            letterSpacing: 1,
                          )
                      : Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: whiteColor, letterSpacing: 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToNextPage(BuildContext context, int index) {
    final link = details.socialLinks.isNotEmpty ? details.socialLinks[0] : null;

    if (details.label == 'Facebook' && link != null) {
      _launchUrl(link.url);
    } else if (details.label == 'Instagram' && link != null) {
      _launchUrl(link.url);
    } else if (details.label == 'Linkedin' && link != null) {
      _launchUrl(link.url);
    } else if (details.label == 'Gmail' && link != null) {
      launchEmail(link.url);
    }
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

  Future<void> launchEmail(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=Subject&body=Body',
    );

    if (await launchUrl(emailLaunchUri)) {
      await canLaunchUrl(emailLaunchUri);
    } else {
      throw 'Could not launch email';
    }
  }
}
