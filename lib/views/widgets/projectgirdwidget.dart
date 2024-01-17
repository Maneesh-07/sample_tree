import 'package:flutter/material.dart';
import 'package:sample_tree/constant/constant.dart';
import 'package:sample_tree/model/contact_model.dart';
import 'package:sample_tree/model/suggestion_model.dart';
import 'package:sample_tree/services/get_suggestion.dart';
import 'package:sample_tree/services/vcard_services.dart';
import 'package:sample_tree/views/widgets/contaner_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html';

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
  late ApiServiceForContactDetails apiServiceForContactDetails;

  late List<GetSuggestion>? suggestionDetails;
  late String contactVCard;

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    apiServicesSuggestionDetails = ApiServicesSuggestionDetails();
    apiServiceForContactDetails = ApiServiceForContactDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 5, 25, 0),
          child: FutureBuilder(
            // Use Future.wait to wait for both API calls to complete
            future: Future.wait([
              apiServicesSuggestionDetails.fetchSuggestion(),
              apiServiceForContactDetails.fetchContactVCard(),
            ]),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.data == null ||
                  snapshot.data![0] == null ||
                  snapshot.data![1] == null) {
                return const Text("No Products Available");
              }

              List results = snapshot.data!;

              // First element is suggestion details
              suggestionDetails = results[0];

              // Second element is contact details
              List<ContactUs> contacts = results[1];

              String contactVCard = contacts[0].data;

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
                      _navigateToNextPage(
                        context,
                        index,
                        suggestionDetails,
                        contactVCard,
                      );
                    },
                    index: index,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _navigateToNextPage(
    BuildContext context,
    int index,
    List<GetSuggestion>? selectedIndex,
    String vCard,
  ) {
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
      // Now you can use downloadProvider in this block

      sampleExcelFormat(vCard);

      // downloadProvider.downloadVCard(samplevcard);
    }
  }

  void sampleExcelFormat(String vcard) {
    window.open(vcard, '_blank');
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

class ContactTextForm extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final double height;
  final TextInputType inputType;
  final int? maxLine;
  const ContactTextForm(
      {super.key,
      required this.labelText,
      this.controller,
      required this.height,
      required this.inputType,
      this.maxLine});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: SizedBox(
          height: height,
          // decoration: BoxDecoration(
          //   borderRadius: const BorderRadius.all(Radius.circular(10)),
          //   border: Border.all(color: Colors.grey.shade300, width: 1),
          // ),
          child: TextFormField(
            controller: controller,
            maxLines: 10,
            maxLength: maxLine,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10),
              hintText: labelText,
              fillColor: Colors.white,
              hintStyle: TextStyle(color: Colors.white),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 76, 76, 77)),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            keyboardType: inputType,
          ),
        ),
      ),
    );
  }
}
