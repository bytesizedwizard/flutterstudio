import 'package:flutter/material.dart';
import 'package:flutter_studio/utils/colors.dart';

/// The custom widget class for screen background with ellipse overlay
class ScreenBackgroundOverlay extends Stack {

  final Widget child;

  ScreenBackgroundOverlay({this.child}): super(
    children: <Widget>[
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                AppColors.primaryColor,
                AppColors.secondaryColor
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              tileMode: TileMode.clamp
          ),
        ),
      ),
      CustomPaint(
        painter: _BackgroundEllipsePainter(),
        child: SizedBox.expand(),
        willChange: false,
      ),
      CustomPaint(
        painter: _ForegroundEllipsePainter(),
        child: SizedBox.expand(),
        willChange: false,
      )
    ]
  );
}

/// The custom widget class for a simple screen background
/// without any ellipse overlay
class ScreenBackgroundBasic extends Container {

  final Widget child;

  ScreenBackgroundBasic({this.child}): super(
    decoration: BoxDecoration(
      gradient: LinearGradient(
          colors: [
          AppColors.primaryColor,
          AppColors.secondaryColor
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        tileMode: TileMode.clamp,
      ),
    ),
    child: child,
  );
}



class _BackgroundEllipsePainter extends CustomPainter {

  final Paint _customPaint = Paint()
  ..color = AppColors.fontPrimaryColor.withOpacity(0.05)
  ..isAntiAlias = true
  ..strokeWidth = 4.0
  ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(2 *size.width, 0), 1.75 * size.width, _customPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

}

class _ForegroundEllipsePainter extends CustomPainter {

  final Paint _customPaint = Paint()
    ..color = AppColors.fontPrimaryColor.withOpacity(0.05)
    ..isAntiAlias = true
    ..strokeWidth = 4.0
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(2* size.width, 0), (2* size.width), _customPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }

}