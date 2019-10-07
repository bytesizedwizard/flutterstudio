import 'package:flutter/material.dart';
import 'package:flutter_studio/utils/colors.dart';

class CustomButton extends StatelessWidget {

  final Widget child;
  final VoidCallback onPressed;
  final Color buttonColor;

  CustomButton({@required this.child, @required this.onPressed, this.buttonColor}) : assert(child != null && onPressed != null);

  CustomButton.secondary({
    @required this.child,
    @required this.onPressed,
    this.buttonColor
  }) : assert(child != null && onPressed != null);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 50,
      buttonColor: buttonColor ?? AppColors(0xFF006AD3),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0)
        ),
        elevation: 7.0,
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
