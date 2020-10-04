import 'package:flutter/material.dart';
import 'package:flutter_studio/ui/components/screen_background.dart';
import 'package:flutter_studio/ui/components/styles.dart';
import 'package:flutter_studio/utils/colors.dart';

class NewWidget extends StatefulWidget {
  @override
  _NewWidgetState createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  @override
  Widget build(BuildContext context) {
    return ScreenBackgroundBasic(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.transparent,
          title: Text(
            "New Widget",
            style: CustomStyles.appBarTitleStyle,
          ),
          titleSpacing: 0.0,
          elevation: 0.0,
        ),
        backgroundColor: AppColors.transparent,
      ),
    );
  }
}
