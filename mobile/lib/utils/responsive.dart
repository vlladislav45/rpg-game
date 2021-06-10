
import 'package:flutter/material.dart';

/***
 * Helper class for better responsive design
 */
class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget desktop;
  final Widget tablet;

  const ResponsiveWidget({Key key, this.mobile, this.desktop, this.tablet}) : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 850;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
          MediaQuery.of(context).size.width >= 850;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if(size.width >= 1100)
      return this.desktop;
    else if(size.width >= 850)
      return this.tablet;
    else return this.mobile;
  }
}