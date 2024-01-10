/*



class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ApiServicesForCompaniesDetails apiServicesForCompaniesDetails;
  int selectedTabIndex = 0;
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
    apiServicesForCompaniesDetails = ApiServicesForCompaniesDetails();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _handleScroll() {
    if (_scrollController.offset > 0 && !_isScrolled) {
      setState(() {
        _isScrolled = true;
      });
    } else if (_scrollController.offset <= 0 && _isScrolled) {
      setState(() {
        _isScrolled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: ListView(
          controller: _scrollController,
          children: [ scrollBuilder()]),
      ),
    );
  }

  FutureBuilder<List<FetchCompanies>> scrollBuilder() {
    return FutureBuilder<List<FetchCompanies>>(
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

            return Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    gradient: scaffoldGradient,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!Responsive.isMobileLarge(context))
                      const SizedBox(height: defaultPadding / 2),
                    _buildCustomAppBar(context, details),
                    if (!Responsive.isMobile(context))
                      _buildTabBarView(context),
                    if (Responsive.isMobile(context))
                      _buildTabBarView(context),
                  ],
                ),
              ],
            );
          },
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
        width: MediaQuery.of(context).size.width,
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
          padding: const EdgeInsets.all(13.0),
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
                              radius: 10,
                              child: Image.asset('assets/gif.gif'),
                            ),
                          ),
                          SizedBox(
                            width: Responsive.isMobile(context)
                                ? MediaQuery.of(context).size.width / 1.6
                                : MediaQuery.of(context).size.width / 1.5,
                          ),
                          CircleAvatar(
                            child: SizedBox(
                              height: Responsive.isDesktop(context) &&
                                      Responsive.isMobile(context)
                                  ? MediaQuery.of(context).size.height * 0.4
                                  : MediaQuery.of(context).size.height * 0.06,
                              width: Responsive.isDesktop(context)
                                  ? MediaQuery.of(context).size.width * 0.1
                                  : MediaQuery.of(context).size.width * 0.15,
                              child: CachedNetworkImage(
                                color: bgColor,
                                imageUrl:
                                    'https://admin.scanetapp.com/storage/app/public/${company.logo}',
                                fit: BoxFit.fitHeight,
                                imageBuilder: (context, imageProvider) =>
                                    Padding(
                                  padding: const EdgeInsets.only(left: 0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: double.maxFinite,
                                      decoration: BoxDecoration(
                                        color: bgColor,
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
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
                                      width: MediaQuery.of(context).size.width,
                                      height: double.maxFinite,
                                      decoration: const BoxDecoration(
                                        color: whiteColor,
                                      ),
                                      child: const CupertinoActivityIndicator(),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Padding(
                                  padding: const EdgeInsets.only(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
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
                                ),
                              ),
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
                            ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  letterSpacing: 2,
                                  color: Colors.white,
                                )
                            : Theme.of(context).textTheme.bodyMedium!.copyWith(
                                  color: Colors.white,
                                  letterSpacing: 2,
                                ),
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
                                ? Theme.of(context).textTheme.bodySmall!.copyWith(
                                      color: Colors.white,
                                      letterSpacing: 1,
                                    )
                                : Theme.of(context).textTheme.bodyMedium!.copyWith(
                                      color: Colors.white,
                                      fontFamily: 'arial',
                                      letterSpacing: 1,
                                    ),
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
                                  : MediaQuery.of(context).size.height * 0.04,
                              width: Responsive.isDesktop(context)
                                  ? MediaQuery.of(context).size.width * 0.1
                                  : MediaQuery.of(context).size.width * 0.07,
                              child: CachedNetworkImage(
                                color: bgColor,
                                imageUrl:
                                    'https://admin.scanetapp.com/storage/app/public/${company.logo}',
                                fit: BoxFit.fitHeight,
                                imageBuilder: (context, imageProvider) =>
                                    Padding(
                                  padding: const EdgeInsets.only(left: 0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: double.maxFinite,
                                      decoration: BoxDecoration(
                                        color: bgColor,
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
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
                                      width: MediaQuery.of(context).size.width,
                                      height: double.maxFinite,
                                      decoration: const BoxDecoration(
                                        color: whiteColor,
                                      ),
                                      child: const CupertinoActivityIndicator(),
                                    ),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Padding(
                                  padding: const EdgeInsets.only(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
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
                                ),
                              ),
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

*/