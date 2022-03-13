import 'package:dukkantek/dukkantek.dart';

TextTheme get theme => GoogleFonts.soraTextTheme();

TextStyle bodyMediumStyle(Color? color) {
  return theme.bodyMedium
          ?.copyWith(color: color ?? DTColors.primary, fontSize: 14) ??
      const TextStyle();
}

TextStyle bodySmallStyle(Color? color) {
  return theme.bodySmall
          ?.copyWith(color: color ?? DTColors.primary, fontSize: 12) ??
      const TextStyle();
}

TextStyle bodyLargeStyle(Color? color) {
  return theme.bodyLarge
          ?.copyWith(color: color ?? DTColors.primary, fontSize: 16) ??
      const TextStyle();
}

TextStyle headlineStyle(Color? color) {
  return theme.headline4
          ?.copyWith(color: color ?? DTColors.primary, fontSize: 22) ??
      const TextStyle();
}

TextStyle buttonStyle(Color? color) {
  return theme.button?.copyWith(color: color ?? DTColors.white, fontSize: 18) ??
      const TextStyle();
}
