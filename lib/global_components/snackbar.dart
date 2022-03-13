import 'package:dukkantek/dukkantek.dart';

void showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    behavior: SnackBarBehavior.floating,
    content: message.text.bodySmall(color: DTColors.white).make(),
    backgroundColor: DTColors.primary,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
