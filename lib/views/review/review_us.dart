import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sample_tree/constant/constant.dart';
import 'package:sample_tree/responsive.dart';
import 'package:sample_tree/views/5_star/five_start_review.dart';
import 'package:sample_tree/views/review_content/review_content.dart';

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
          // IconWidget(),
          Center(
            child: RatingBarWidget(
              rating: 0,
              ratingCount: 12,
            ),
          )
        ],
      ),
    );
  }
}

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

class _Cliper extends CustomClipper<Rect> {
  final int part;
  _Cliper({required this.part});

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(
      (size.width / 10) * part,
      0.0,
      size.width,
      size.width,
    );
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => true;
}

// class IconWidget extends StatefulWidget {
//   const IconWidget({
//     super.key,
//   });

//   @override
//   State<IconWidget> createState() => _IconWidgetState();
// }

// class _IconWidgetState extends State<IconWidget> {
//   num values = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           RatingBar.builder(
//             initialRating: 0,
//             minRating: 1,
//             direction: Axis.horizontal,
//             allowHalfRating: false,
//             itemCount: 5,
//             itemPadding: const EdgeInsets.symmetric(horizontal: 4),
//             itemBuilder: (context, index) {
//               return Icon(
//                 isChecking ? CupertinoIcons.star : CupertinoIcons.star_fill,
//                 color: isChecking ? bgColor : primaryColor,
//               );
//             },
//             onRatingUpdate: (value) {
//               values = value;
//               print(value);
//             },
//           ),
//           const SizedBox(
//             height: defaultPadding,
//           ),
//           TextButton(
//             onPressed: () {
//               if (values == 0) {
//                 Responsive.isDesktop(context)
//                     ? ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                         content: Text("Please Select any star"),
//                       ))
//                     : showToast('Please Select any star');
//               } else if (values == 1 || values == 2 || values == 3) {
//                 Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => const ReviewContent(),
//                 ));
//               } else if (values == 4 || values == 5) {
//                 Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => const FiveStar(),
//                 ));
//               }
//             },
//             style: TextButton.styleFrom(
//               fixedSize: const Size(120, 0),
//               foregroundColor: whiteColor,
//               backgroundColor: kButtonColorBlue,
//               padding: const EdgeInsets.symmetric(
//                 vertical: 8,
//                 horizontal: 5,
//               ),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//             child: const Text('Submit'),
//           )
//         ],
//       ),
//     );
//   }

//   void showToast(String message) {
//     Fluttertoast.showToast(
//       msg: message,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.SNACKBAR,
//       timeInSecForIosWeb: 2000,
//       backgroundColor: Colors.black.withOpacity(0.7),
//       textColor: Colors.white,
//       fontSize: 16.0,
//     );
//   }
// }
