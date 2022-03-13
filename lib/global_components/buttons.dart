import 'package:dukkantek/dukkantek.dart';

enum CtaStyle { active, inactive, outline, social }

class DTButton extends StatefulWidget {
  const DTButton(
    this.child,
    this.ctaStyle,
    this.click, {
    Key? key,
    this.loading = false,
    this.animate = true,
  }) : super(key: key);

  final Widget child;
  final CtaStyle ctaStyle;
  final ClickFunction click;
  final bool loading;
  final bool animate;

  @override
  _DTButtonState createState() => _DTButtonState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<CtaStyle>('ctaStyle', ctaStyle))
      ..add(DiagnosticsProperty<ClickFunction>('click', click))
      ..add(DiagnosticsProperty<bool>('loading', loading))
      ..add(DiagnosticsProperty<bool>('animate', animate));
  }
}

class _DTButtonState extends State<DTButton> with TickerProviderStateMixin {
  Widget child = Container();

  @override
  void initState() {
    child = widget.child.centre;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ClickFunction clickFunction =
        widget.ctaStyle != CtaStyle.inactive ? widget.click : ClickFunction('');

    Widget functionalButton() => AnimatedContainer(
          width: widget.loading
              ? DTDec.ctaHeight
              : MediaQuery.of(context).size.width,
          duration: const Duration(milliseconds: 250),
          height: DTDec.ctaHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(
                widget.loading ? DTDec.ctaHeight / 2 : DTDec.borderRadius)),
            color: getCtaColor(),
            border: Border.all(
                color: widget.ctaStyle == CtaStyle.social
                    ? DTColors.primary
                    : DTColors.secondary.withOpacity(
                        widget.ctaStyle == CtaStyle.inactive ? 0.0 : 1,
                      ),
                width: 1),
          ),
          child: widget.loading
              ? circularProgress(
                  color: widget.ctaStyle == CtaStyle.outline
                      ? DTColors.secondary
                      : widget.ctaStyle == CtaStyle.social
                          ? DTColors.primary
                          : DTColors.white)
              : child.centre,
        ).circularBorder;

    Widget nonAnimatingButton() => Container(
          height: DTDec.ctaHeight,
          decoration: BoxDecoration(
            borderRadius:
                const BorderRadius.all(Radius.circular(DTDec.borderRadius)),
            color: getCtaColor(),
            border: Border.all(
                color: (widget.ctaStyle == CtaStyle.social
                        ? DTColors.primary
                        : DTColors.secondary)
                    .withOpacity(
                  widget.ctaStyle == CtaStyle.inactive ? 0.0 : 1,
                ),
                width: 1),
          ),
          child: widget.loading
              ? circularProgress(
                  color: widget.ctaStyle == CtaStyle.outline
                      ? DTColors.secondary
                      : widget.ctaStyle == CtaStyle.social
                          ? DTColors.primary
                          : DTColors.white)
              : child.centre,
        ).circularBorder;

    return widget.loading
        ? widget.animate
            ? functionalButton().centre
            : nonAnimatingButton().centre
        : widget.animate
            ? functionalButton().onClick(clickFunction).centre
            : nonAnimatingButton().onClick(clickFunction).centre;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(EnumProperty<CtaStyle>('ctaStyle', widget.ctaStyle))
      ..add(DiagnosticsProperty<ClickFunction>('click', widget.click))
      ..add(DiagnosticsProperty<bool>('loading', widget.loading));
  }

  Color getCtaColor() {
    switch (widget.ctaStyle) {
      case CtaStyle.active:
        return DTColors.secondary.withOpacity(0.98);

      case CtaStyle.inactive:
        return DTColors.secondary.withOpacity(
          0.32,
        );

      case CtaStyle.outline:
        return DTColors.white;

      case CtaStyle.social:
        return DTColors.white;
    }
  }
}
