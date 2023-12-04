import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample_tree/constant/constant.dart';
import 'package:sample_tree/responsive.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xff060529),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCustomAppBar(context),
              _buildTabBarView(context),
            ],
          ),
        ),
      ),
    );
  }

  static const List<String> contentNames = [
    'Reviews',
    'payments',
    'Instagram',
    'facebook',
  ];

  Widget _buildCustomAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        height: MediaQuery.of(context).size.height * 0.22,
        width: MediaQuery.of(context).size.width * 0.22,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 77, 71, 71).withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 8),
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
                style: GoogleFonts.robotoSerif(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              Text(
                "Daily News",
                style: GoogleFonts.robotoSerif(
                  fontSize: 20,
                  color: Colors.white,
                ),
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
                      color: Colors.white,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Payment",
                    style: GoogleFonts.robotoSerif(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Review us",
                    style: GoogleFonts.robotoSerif(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Follow Us",
                    style: GoogleFonts.robotoSerif(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  MyProjects(),
                  MyProjects(),
                  MyProjects(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 2,
          crossAxisSpacing: 30,
          mainAxisSpacing: 15,
          crossAxisCount: 2,
        ),
        itemCount: contentNames.length,
        itemBuilder: (context, index) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.22,
            width: MediaQuery.of(context).size.width * 0.60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.teal,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ContainerWidget(
              text1: contentNames[index],
              text2: '',
              imgUrl: '',
            ),
          );
        },
      ),
    );
  }
}

class MyProjects extends StatelessWidget {
  const MyProjects({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: defaultPadding,
        ),
        Responsive(
          mobile: ProjectsGridView(crossAxisCount: 1, childAspectRatio: 1.7),
          mobileLarge: ProjectsGridView(
            crossAxisCount: 2,
          ),
          tablet: ProjectsGridView(
            childAspectRatio: 1.1,
          ),
          desktop: ProjectsGridView(),
        )
      ],
    );
  }
}

class ProjectsGridView extends StatelessWidget {
  const ProjectsGridView({
    super.key,
    this.crossAxisCount = 3,
    this.childAspectRatio = 1.3,
  });
  final int crossAxisCount;
  final double childAspectRatio;
  static const List<String> contentNames = [
    'Reviews',
    'payments',
    'Instagram',
    'facebook',
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
            crossAxisSpacing: defaultPadding,
            mainAxisSpacing: defaultPadding,
          ),
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) => ContainerWidget(
            text1: contentNames[index],
            text2: '',
            imgUrl: '',
          ),
        ),
      ),
    );
  }
}

class ContainerWidget extends StatelessWidget {
  final String text1;
  final String text2;
  final String imgUrl;
  const ContainerWidget({
    super.key,
    required this.text1,
    required this.text2,
    required this.imgUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width * 0.60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.teal,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              text1,
              style: GoogleFonts.robotoSerif(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
            Text(
              text2,
              style: GoogleFonts.robotoSerif(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
