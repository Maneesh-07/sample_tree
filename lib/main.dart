import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sample_tree/constant/constant.dart';
import 'package:sample_tree/views/home/home_dash.dart';
import 'dart:js' as js;

String? uid;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  uid = js.context['myParam'];
  await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((_) => runApp(MyApp(uid: uid)));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, this.uid});
  final String? uid;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    print("Inside :::${widget.uid}");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        useMaterial3: false,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: scaffoldBgColor,
        canvasColor: bgColor,
        textTheme: Theme.of(context)
            .textTheme
            .apply(bodyColor: Colors.white, fontFamily: 'arial')
            .copyWith(
              bodySmall:
                  const TextStyle(color: bodyTextColor, fontFamily: 'arial'),
              bodyMedium:
                  const TextStyle(color: bodyTextColor, fontFamily: 'arial'),
            ),
      ),
      home: const DashBoard(),
    );
  }
}
