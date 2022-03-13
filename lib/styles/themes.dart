import 'package:dukkantek/dukkantek.dart';
import 'package:dukkantek/global_components/text/text_styles.dart';

class DTTheme {
  DTTheme._();

  static ThemeData theme = ThemeData(
    canvasColor: DTColors.white,
    primarySwatch: DTColors.primary,
    backgroundColor: DTColors.secondary,
    splashColor: DTColors.primary,
    inputDecorationTheme: InputDecorationTheme(
        labelStyle: bodySmallStyle(DTColors.primary),
        hintStyle: bodySmallStyle(DTColors.primary.withOpacity(0.5)),
        errorStyle: bodySmallStyle(Colors.red),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        floatingLabelStyle: const TextStyle(
          color: DTColors.primary,
        ),
        border: border(),
        enabledBorder: border(),
        focusedBorder: border(),
        errorBorder: border(color: Colors.red)),
    textTheme: const TextTheme(
      headline1: TextStyle(color: DTColors.secondary),
      headline4: TextStyle(color: DTColors.secondary),
      bodyText2:
          TextStyle(color: DTColors.primary, fontWeight: FontWeight.bold),
      bodyText1: TextStyle(color: Colors.grey),
    ),
  );

  static OutlineInputBorder border({Color? color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(DTDec.borderRadius),
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: color ?? DTColors.primary,
      ),
    );
  }
}
