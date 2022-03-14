import 'package:dukkantek/dukkantek.dart';
import 'package:dukkantek/global_components/text/text.dart';

extension StringExtensions on String {
  String removeUnwanted() {
    const String unwanted = '‎';
    const String unwanted1 = '‏';
    final String s = replaceAll(unwanted, '').replaceAll(unwanted1, '');

    return s;
  }

  bool get isValidEmailAddress {
    const String p =
        r"^([a-z0-9,!\#\$%&'\*\+\/=\?\^_`\{\|\}~-]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z0-9,!\#\$%&'\*\+\/=\?\^_`\{\|\}~-]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*@([a-z0-9-]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z0-9-]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*\.(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]){2,})$";
    const String p1 =
        r'^([a-zA-Z0-9_\-\.]+)@(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.)+[a-zA-Z0-9]{2}(?:[a-zA-Z0-9-]*[a-zA-Z0-9])?$';
    final RegExp regExp = RegExp(p);
    final RegExp reg = RegExp(p1);

    return reg.hasMatch(toLowerCase()) && regExp.hasMatch(toLowerCase());
  }

  DTButton ctaActive(ClickFunction click,
      {bool overrideLineHeight = true,
      bool loading = false,
      bool disable = false,
      Key? key}) {
    return _ctaStyle()
        .ctaActive(click, loading: loading, disable: disable, key: key);
  }

  Widget dividerText({Color? color}) {
    return Row(
      children: [
        Flexible(
          child: Container(height: 1, color: color ?? DTColors.grey),
        ),
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: text.bodySmall(color: color ?? DTColors.grey).make()),
        Flexible(
          child: Container(height: 1, color: color ?? DTColors.grey),
        ),
      ],
    );
  }

  Widget assetImage(
      {double? width, double? height, BoxFit? fit, Color? color}) {
    return Image.asset(
      this,
      width: width,
      height: height,
      fit: fit,
      color: color,
    );
  }

  DTText get text {
    return DTText(removeUnwanted());
  }

  Widget _ctaStyle() {
    return text.button().maxLines(1).make();
  }
}
