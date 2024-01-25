import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sample_tree/constant/constant.dart';
import 'package:sample_tree/main.dart';
import 'package:sample_tree/responsive.dart';

class AppointmentBooked extends StatelessWidget {
  const AppointmentBooked({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height / 20,
                  ),
                  Responsive.isMobile(context)
                      ? Lottie.asset(
                          'assets/success.json',
                          height: MediaQuery.sizeOf(context).height / 2.5,
                        )
                      : Lottie.network('assets/success.json'),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: const Text(
                      'Thanks For Your valuable Review',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'arial',
                        color: whiteColor,
                      ),
                    ),
                  ),
                  kHeight,
                  kHeight,
                  TextButton(
                    onPressed: () async {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                          builder: (context) => const MyApp(),
                        ),
                        (route) => false,
                      );
                    },
                    style: TextButton.styleFrom(
                      fixedSize: const Size(140, 40),
                      foregroundColor: whiteColor,
                      backgroundColor: green,
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 5,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Back to Home'),
                  )
                ],
              ),
            ),

            //back to home page
          ],
        ),
      ),
    );
  }
}
