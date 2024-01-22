import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sample_tree/main.dart';
import 'package:sample_tree/responsive.dart';
import 'package:sample_tree/views/widgets/button.dart';

class AppointmentBooked extends StatelessWidget {
  const AppointmentBooked({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Responsive.isMobile(context) && Responsive.isDesktop(context)
                  ? Lottie.network('assets/success.json')
                  : Lottie.network('assets/success.json'),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: const Text(
                'Successfully Booked',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            //back to home page
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 15),
              child: Button(
                width: double.infinity,
                title: 'Back to Home Page',
                onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const MyApp(),
                  ),
                  (route) => false,
                ),
                disable: false,
              ),
            )
          ],
        ),
      ),
    );
  }
}
