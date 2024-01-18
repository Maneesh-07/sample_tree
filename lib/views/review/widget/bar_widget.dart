import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sample_tree/constant/constant.dart';
import 'package:sample_tree/responsive.dart';
import 'package:sample_tree/views/5_star/five_start_review.dart';
import 'package:sample_tree/views/review_content/review_content.dart';


class RatingBarWidget extends StatefulWidget {
  final num rating;
  final num size;
  int? ratingCount;
  RatingBarWidget(
      {super.key, required this.rating, this.ratingCount, this.size = 40});

  @override
  State<RatingBarWidget> createState() => _RatingBarWidgetState();
}

class _RatingBarWidgetState extends State<RatingBarWidget> {
  num filledStars = 0;

  @override
  void initState() {
    super.initState();
    filledStars = widget.rating;
  }

  void resetStars() {
    setState(() {
      filledStars = widget.rating;
    });
  }

  void _onStarTap(int index) {
    setState(() {
      if (filledStars > index) {
        filledStars = index;
      } else {
        filledStars = index + 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> starList = [];

    for (int i = 0; i < 5; i++) {
      starList.add(
        GestureDetector(
          onTap: () => _onStarTap(i),
          child: Icon(
            i < filledStars ? CupertinoIcons.star_fill : Icons.star,
            color: i < filledStars ? primaryColor : colorGrey,
            size: widget.size.toDouble(),
          ),
        ),
      );
    }

    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: starList,
        ),
        const SizedBox(
          height: defaultPadding,
        ),
        TextButton(
          onPressed: () {
            if (filledStars == 0) {
              Responsive.isDesktop(context)
                  ? ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please Select any star"),
                    ))
                  : showToast('Please Select any star');
            } else if (filledStars == 1 ||
                filledStars == 2 ||
                filledStars == 3) {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                    builder: (context) =>  ReviewContent(star: filledStars,),
                  ))
                  .then((_) => resetStars());
            } else if (filledStars == 4 || filledStars == 5) {
              Navigator.of(context)
                  .push(MaterialPageRoute(
                    builder: (context) => const FiveStar(),
                  ))
                  .then((_) => resetStars());
            }
          },
          style: TextButton.styleFrom(
            fixedSize: const Size(120, 0),
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
    );
  }

  void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 2000,
      backgroundColor: Colors.black.withOpacity(0.7),
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
