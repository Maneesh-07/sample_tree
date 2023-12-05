import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sample_tree/constant/constant.dart';

bool isChecking = false;

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const IconWidget(),
          const SizedBox(
            height: 15,
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Submit'),
          )
        ],
      ),
    );
  }
}

class IconWidget extends StatefulWidget {
  const IconWidget({
    super.key,
  });

  @override
  State<IconWidget> createState() => _IconWidgetState();
}

class _IconWidgetState extends State<IconWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RatingBar.builder(
            initialRating: 0,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemPadding: const EdgeInsets.symmetric(horizontal: 4),
            itemBuilder: (context, index) {
              return Icon(
                isChecking ? CupertinoIcons.star : CupertinoIcons.star_fill,
                color: isChecking ? bgColor : primaryColor,
              );
            },
            onRatingUpdate: (value) {
              print(value);
            },
          )
        ],
      ),
    );
  }
}
