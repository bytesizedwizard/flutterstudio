import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_studio/ui/canvas_dashboard.dart';
import 'package:flutter_studio/utils/colors.dart';
import 'components/screen_background.dart';
import 'components/buttons.dart';
import 'components/styles.dart';


/// The first screen shown to the user after the splash screen.
/// Provides a brief message about the project idea.
class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          Positioned.fill(
            child: ScreenBackgroundOverlay(),
          ),
          Positioned.fill(
            child: SafeArea(
              minimum: EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 50.0,
                bottom: 25.0
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    flex: 1,
                    child: Text(
                      "Welcome to",
                      style: TextStyle(
                        color: AppColors.primaryFontColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  SizedBox(height: 25.0,),
                  Flexible(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          "assets/images/flutter_studio_logo.png",
                          alignment: Alignment.topLeft,
                          width: 165,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25.0,),
                  Flexible(
                    flex: 14,
                    child: ListView(
                      children: <Widget>[
                        Text(
                          "Flutter Studio is an open source interactive Dart code generator developed in Flutter, the hybrid mobile programming framework based on the Dart language, made by Google.",
                          style: TextStyle(
                              fontSize: 14,
                              color: AppColors.primaryFontColor,
                              fontWeight: FontWeight.w300,
                              height: 1.25
                          ),
                        ),
                        SizedBox(height: 25.0,),
                        Text(
                          "Initially developed as an official submission for the first ever Flutter International Hackathon, this project aims to help make flutter as fast and easy to learn as possible for beginners as well as seasoned developers.",
                          style: TextStyle(
                              fontSize: 14,
                              color: AppColors.primaryFontColor,
                              fontWeight: FontWeight.w300,
                              height: 1.25
                          ),
                        ),
                        SizedBox(height: 25.0,),
                        Text(
                          "We hope this project can serve as a starting point to all those who are looking to try out flutter, and in due course of time, can evolve into something much more.",
                          style: TextStyle(
                              fontSize: 14,
                              color: AppColors.primaryFontColor,
                              fontWeight: FontWeight.w300,
                              height: 1.25
                          ),
                        ),
                        SizedBox(height: 25.0,),
                        Text(
                          "Let's build something great together!",
                          style: TextStyle(
                              fontSize: 18,
                              color: AppColors.primaryFontColor,
                              fontWeight: FontWeight.w600,
                              height: 1.25
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25.0,),
                  Flexible(
                    flex: 2,
                    fit: FlexFit.loose,
                    child: CustomButton(
                      child: Text(
                        "Get Started",
                        style: CustomStyles.ButtonTextStyle,
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => StudioDashboard(),
                          ),
                        );
                      },
                    )
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
