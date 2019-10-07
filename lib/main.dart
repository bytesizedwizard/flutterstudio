import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_studio/utils/colors.dart';
import 'package:flutter_studio/ui/welcome.dart';
import 'package:flutter_studio/bloc/provider.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new FlutterStudio());
  });
}

class FlutterStudio extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        home: WelcomeScreen(),
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
        ),
      ),
    );
  }
}


