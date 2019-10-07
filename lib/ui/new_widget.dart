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
          bottom: PreferredSize(
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(
                    "Select widget category",
                    style: CustomStyles.appBarSubTitleStyle,
                  ),
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(left: 55,),
                ),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20,),
                  child: Divider(
                    color: AppColors.fontPrimaryColor.withOpacity(0.30),
                    thickness: 1.0,
                  ),
                ),
              ],
            ),
            preferredSize: Size.fromHeight(25),
          ),
        ),
        backgroundColor: AppColors.transparent,
      ),
    );
  }
}
