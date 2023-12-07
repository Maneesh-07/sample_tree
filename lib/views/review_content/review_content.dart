import 'package:flutter/material.dart';
import 'package:sample_tree/constant/constant.dart';
import 'package:sample_tree/responsive.dart';

class ReviewContent extends StatefulWidget {
  const ReviewContent({super.key});

  @override
  State<ReviewContent> createState() => _ReviewContentState();
}

class _ReviewContentState extends State<ReviewContent> {
  final namecontroller = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: defaultPadding,
            ),
            kHeight,
            Text(
              'We Want Our Customer to be 100% Satisfied..\nPlease let us know why you had a bad experience,\nso we can improve our service.',
              style: Responsive.isDesktop(context)
                  ? Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.bold, color: whiteColor)
                  : Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.bold, color: whiteColor),
            ),
            kHeight,
            Padding(
              padding: const EdgeInsets.only(right: 140),
              child: Text(
                'Leave Your Message here..',
                style: Responsive.isDesktop(context)
                    ? Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold, color: whiteColor)
                    : Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold, color: whiteColor),
              ),
            ),
            kHeight,
            ReviewTextForm(
              controller: namecontroller,
              labelText: 'Name',
              height: 55,
              inputType: TextInputType.name,
            ),
            kHeight,
            ReviewTextForm(
              controller: phoneController,
              labelText: 'Phone No',
              height: 55,
              inputType: TextInputType.phone,
              maxLine: 10,
            ),
            kHeight,
            ReviewTextForm(
              controller: emailController,
              labelText: 'Email',
              height: 55,
              inputType: TextInputType.emailAddress,
            ),
            kHeight,
            ReviewTextForm(
              controller: addressController,
              labelText: 'Address',
              height: 110,
              inputType: TextInputType.streetAddress,
            ),
            kHeight,
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                fixedSize: const Size(70, 0),
                foregroundColor: whiteColor,
                backgroundColor: kButtonColorBlue,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}

class ReviewTextForm extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final double height;
  final TextInputType inputType;
  final int? maxLine;
  const ReviewTextForm(
      {super.key,
      required this.labelText,
      required this.controller,
      required this.height,
      required this.inputType,
      this.maxLine});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: TextFormField(
          controller: controller,
          maxLines: 10,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
            hintText: labelText,
            fillColor: Colors.white,
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 240, 243, 245)),
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
    );
  }
}
