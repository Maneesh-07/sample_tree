import 'package:flutter/material.dart';
import 'package:sample_tree/constant/constant.dart';
import 'package:sample_tree/responsive.dart';
import 'package:sample_tree/views/widgets/projectgirdwidget.dart';

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
          mobile: ProjectsGridView(
            crossAxisCount: 2,
            childAspectRatio: 1,
          ),
          mobileLarge: ProjectsGridView(
            crossAxisCount: 2,
          ),
          tablet: ProjectsGridView(
            childAspectRatio: 1.1,
          ),
          desktop: ProjectsGridView(
            crossAxisCount: 4,
          ),
        ),
      ],
    );
  }
}
