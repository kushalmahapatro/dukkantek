import 'package:dukkantek/dukkantek.dart';
import 'package:dukkantek/global_components/text/text_styles.dart';

abstract class TextWidgetBuilder<T extends Widget> {
  T make({Key? key});
}

class DTText extends TextWidgetBuilder<Widget> {
  DTText(String s) {
    _text = s;
  }

  late String _text;
  int _maxLines = 0;
  TextStyle _textStyle = bodyMediumStyle(DTColors.primary);
  TextAlign _textAlign = TextAlign.start;

  DTText get center => this.._textAlign = TextAlign.center;

  DTText get start => this.._textAlign = TextAlign.start;

  DTText get end => this.._textAlign = TextAlign.end;

  DTText get justify => this.._textAlign = TextAlign.justify;

  DTText button({Color? color}) {
    _textStyle = buttonStyle(color);
    return this;
  }

  DTText bodySmall({Color? color}) {
    _textStyle = bodySmallStyle(color);
    return this;
  }

  DTText bodyLarge({Color? color}) {
    _textStyle = bodyLargeStyle(color);
    return this;
  }

  DTText headline({Color? color}) {
    _textStyle = headlineStyle(color);
    return this;
  }

  DTText maxLines(int lines) {
    _maxLines = lines;

    return this;
  }

  @override
  Text make({Key? key}) {
    if (_maxLines == 0) {
      return Text(
        _text,
        style: _textStyle,
        textAlign: _textAlign,
      );
    } else {
      return Text(
        _text,
        style: _textStyle,
        maxLines: _maxLines,
        textAlign: _textAlign,
      );
    }
  }
}
