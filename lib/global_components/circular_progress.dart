import 'package:dukkantek/dukkantek.dart';

Widget circularProgress({Color? color, double strokeWidth = 4}) {
  strokeWidth = (strokeWidth <= 0) ? 4 : strokeWidth;
  return SizedBox(
    child: CircularProgressIndicator(
      color: color ?? DTColors.secondary,
      strokeWidth: strokeWidth,
    ),
    width: DTDec.ctaHeight - 20,
    height: DTDec.ctaHeight - 20,
  ).centre;
}
