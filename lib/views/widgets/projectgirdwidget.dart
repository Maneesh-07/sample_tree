import 'package:flutter/material.dart';
import 'package:sample_tree/constant/constant.dart';
import 'package:sample_tree/model/suggestion_model.dart';
import 'package:sample_tree/services/get_suggestion.dart';
import 'package:sample_tree/views/widgets/contaner_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectsGridView extends StatefulWidget {
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
    'Payments',
    'Instagram',
    'facebook',
    'Suggestion',
    'Contact Us',
  ];
  static const List<String> text2 = [
    'Please Review us',
    'UPI & payment Link',
    'Please Follow us',
    'Please Follow Us',
    'Give a suggestion',
    'Contact Us',
  ];
  static const List<String> imageContent = [
    'assets/review.jpg',
    'assets/payment.png',
    'assets/instagram.png',
    'assets/facebook.png',
    'assets/idea.png',
    'assets/contact-us.png',
  ];

  @override
  State<ProjectsGridView> createState() => _ProjectsGridViewState();
}

class _ProjectsGridViewState extends State<ProjectsGridView> {
  late ApiServicesSuggestionDetails apiServicesSuggestionDetails;

  // late List<GetSuggestion>? details;
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    apiServicesSuggestionDetails = ApiServicesSuggestionDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 5, 25, 0),
            child: FutureBuilder<List<GetSuggestion>>(
                future: apiServicesSuggestionDetails.fetchSuggestion(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text("No Products Available");
                  }

                  final details = snapshot.data;
                  selectedIndex = details!.length;
                  return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: widget.crossAxisCount,
                        childAspectRatio: widget.childAspectRatio * 0.9,
                        crossAxisSpacing: defaultPadding,
                        mainAxisSpacing: defaultPadding,
                      ),
                      itemCount: ProjectsGridView.contentNames.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ContainerWidget(
                          text1: ProjectsGridView.contentNames[index],
                          text2: ProjectsGridView.text2[index],
                          imgUrl: ProjectsGridView.imageContent[index],
                          onTap: () {
                            _navigateToNextPage(context, index, details);
                          },
                          index: index,
                        );
                      });
                })),
      ),
    );
  }

  void _navigateToNextPage(
      BuildContext context, int index, List<GetSuggestion>? selectedIndex) {
    TabController tabController = DefaultTabController.of(context);

    if (ProjectsGridView.contentNames[index] == 'Reviews') {
      tabController.animateTo(2);
    } else if (ProjectsGridView.contentNames[index] == 'Payments') {
      tabController.animateTo(1);
    } else if (ProjectsGridView.contentNames[index] == 'Instagram') {
      tabController.animateTo(3);
    } else if (ProjectsGridView.contentNames[index] == 'facebook') {
      tabController.animateTo(3);
    } else if (ProjectsGridView.contentNames[index] == 'Suggestion') {
      print(selectedIndex![0].email);
      launchEmail(selectedIndex[0].email);
    } else if (ProjectsGridView.contentNames[index] == 'Contact Us') {
      print(selectedIndex![0].name);
      print(selectedIndex[0].phone);
      addContact(selectedIndex[0].name, selectedIndex[0].phone);
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

  Future<void> addContact(String name, String phone) async {
    final Uri url = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw ('can not lunch phone');
    }
  }
}
