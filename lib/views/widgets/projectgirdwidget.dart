import 'package:flutter/material.dart';
import 'package:sample_tree/constant/constant.dart';
import 'package:sample_tree/views/widgets/contaner_widget.dart';

class ProjectsGridView extends StatelessWidget {
  final TabController? tabController;
  const ProjectsGridView({
    super.key,
    this.crossAxisCount = 3,
    this.childAspectRatio = 1.3,
    this.tabController,
  });
  final int crossAxisCount;
  final double childAspectRatio;

  static const List<String> contentNames = [
    'Reviews',
    'payments',
    'Instagram',
    'facebook',
  ];
  static const List<String> text2 = [
    'Please Review us',
    'UPI & payment Link',
    'Please Follow us',
    'Please Follow Us',
  ];
  static const List<String> imageContent = [
    'assets/review.jpg',
    'assets/payment.png',
    'assets/instagram.png',
    'assets/facebook.png',
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
            crossAxisSpacing: defaultPadding * 0.1,
            mainAxisSpacing: defaultPadding,
          ),
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) => ContainerWidget(
            text1: contentNames[index],
            text2: text2[index],
            imgUrl: imageContent[index],
            onTap: () => _navigateToNextPage(context, index),
            index: index,
          ),
        ),
      ),
    );
  }

  void _navigateToNextPage(BuildContext context, int index) {
    TabController tabController = DefaultTabController.of(context);

    if (contentNames[index] == 'Reviews') {
      tabController.animateTo(2);
    } else if (contentNames[index] == 'payments') {
      tabController.animateTo(1);
    } else if (contentNames[index] == 'Instagram') {
      tabController.animateTo(3);
    } else if (contentNames[index] == 'facebook') {
      tabController.animateTo(3);
    }
  }
}
