import 'package:flutter/material.dart';
class GradientPainter extends CustomPainter {

  final List<Color> colors;

  GradientPainter({required this.colors});
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final Paint paint = Paint()
      ..shader = LinearGradient(
        colors: colors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(rect);

    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
CustomPainter gradientApply(List<Color> colors) {
  return GradientPainter(colors: colors);
}
Widget gradientText(String text, TextStyle style, Gradient gradient) {
  return ShaderMask(
    shaderCallback: (bounds) => gradient.createShader(
      Rect.fromLTWH(0, 0, bounds.width, bounds.height),
    ),
    child: Text(
      text,
      style: style.copyWith(color: Colors.white), // color must be set, will be masked
    ),
  );
}

Route slideFadeAnimation(Widget page, {bool slideRight = true}) {
  return PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 400), // Smooth transition
    reverseTransitionDuration: Duration(milliseconds: 400),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var slideTween = Tween<Offset>(
        begin: slideRight ? Offset(1.0, 0.0) : Offset(-1.0, 0.0), // Left or Right
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.easeOutExpo));

      var fadeTween = Tween<double>(begin: 0.2, end: 1.0).animate(animation);
      var scaleTween = Tween<double>(begin: 0.85, end: 1.0).animate(
          CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn),
      );

      return FadeTransition(
        opacity: fadeTween, // Smooth fade effect
        child: SlideTransition(
          position: animation.drive(slideTween), // Slide effect
          child: ScaleTransition(scale: scaleTween,child: child,),
        ),
      );
    },
  );

}
