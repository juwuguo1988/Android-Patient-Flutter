import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum IconTextAlignment {
  iconTopTextBottom,//图在上文字在下
  iconBottomTextTop,//图在下文字在上
  iconLeftTextRight,//图在左文字在右
  iconRightTextLeft,//图在右文字在左
  noIconOnlyText,//无图仅包含文字
}

class IconTextButton extends MaterialButton {
  /// Create a simple text button.
  ///
  /// The [autofocus] and [clipBehavior] arguments must not be null.
  const IconTextButton({
    Key key,
    @required VoidCallback onPressed,
    ValueChanged<bool> onHighlightChanged,
    ButtonTextTheme textTheme,
    Color textColor,
    Color disabledTextColor,
    Color color,
    Color disabledColor,
    Color focusColor,
    Color hoverColor,
    Color highlightColor,
    Color splashColor,
    Brightness colorBrightness,
    EdgeInsetsGeometry padding,
    ShapeBorder shape,
    Clip clipBehavior = Clip.none,
    FocusNode focusNode,
    bool autofocus = false,
    MaterialTapTargetSize materialTapTargetSize,
    @required Widget child,
  }) : assert(autofocus != null),
        super(
        key: key,
        onPressed: onPressed,
        onHighlightChanged: onHighlightChanged,
        textTheme: textTheme,
        textColor: textColor,
        disabledTextColor: disabledTextColor,
        color: color,
        disabledColor: disabledColor,
        focusColor: focusColor,
        hoverColor: hoverColor,
        highlightColor: highlightColor,
        splashColor: splashColor,
        colorBrightness: colorBrightness,
        padding: padding,
        shape: shape,
        clipBehavior: clipBehavior,
        focusNode: focusNode,
        autofocus: autofocus,
        materialTapTargetSize: materialTapTargetSize,
        child: child,
      );

  /// Create a text button from a pair of widgets that serve as the button's
  /// [icon] and [label].
  ///
  /// The icon and label are arranged in a row and padded by 12 logical pixels
  /// at the start, and 16 at the end, with an 8 pixel gap in between.
  ///
  /// The [icon], [label], and [clipBehavior] arguments must not be null.
  factory IconTextButton.icon({
    Key key,
    @required VoidCallback onPressed,
    ValueChanged<bool> onHighlightChanged,
    ButtonTextTheme textTheme,
    Color textColor,
    Color disabledTextColor,
    Color color,
    Color disabledColor,
    Color focusColor,
    Color hoverColor,
    Color highlightColor,
    Color splashColor,
    Brightness colorBrightness,
    EdgeInsetsGeometry padding,
    ShapeBorder shape,
    Clip clipBehavior,
    FocusNode focusNode,
    bool autofocus,
    MaterialTapTargetSize materialTapTargetSize,
    double paddingIconText,// 图标和文字之间的间隔
    double paddingLabelToBorder,// 文字到按钮边界的间隔
    Widget backgroundView,
    @required IconTextAlignment iconTextAlignment,
    @required Widget icon,
    @required Widget label,
  }) = _IconTextButtonWithIcon;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ButtonThemeData buttonTheme = ButtonTheme.of(context);
    return RawMaterialButton(
      onPressed: onPressed,
      onHighlightChanged: onHighlightChanged,
      fillColor: buttonTheme.getFillColor(this),
      textStyle: theme.textTheme.button.copyWith(color: buttonTheme.getTextColor(this)),
      focusColor: buttonTheme.getFocusColor(this),
      hoverColor: buttonTheme.getHoverColor(this),
      highlightColor: buttonTheme.getHighlightColor(this),
      splashColor: buttonTheme.getSplashColor(this),
      elevation: buttonTheme.getElevation(this),
      focusElevation: buttonTheme.getFocusElevation(this),
      hoverElevation: buttonTheme.getHoverElevation(this),
      highlightElevation: buttonTheme.getHighlightElevation(this),
      disabledElevation: buttonTheme.getDisabledElevation(this),
      padding: buttonTheme.getPadding(this),
      constraints: buttonTheme.getConstraints(this),
      shape: buttonTheme.getShape(this),
      clipBehavior: clipBehavior ?? Clip.none,
      focusNode: focusNode,
      autofocus: autofocus,
      materialTapTargetSize: buttonTheme.getMaterialTapTargetSize(this),
      animationDuration: buttonTheme.getAnimationDuration(this),
      child: child,
    );
  }
}

/// The type of of FlatButtons created with [FlatButton.icon].
///
/// This class only exists to give FlatButtons created with [FlatButton.icon]
/// a distinct class for the sake of [ButtonTheme]. It can not be instantiated.
class _IconTextButtonWithIcon extends IconTextButton with MaterialButtonWithIconMixin {
  _IconTextButtonWithIcon({
    Key key,
    @required VoidCallback onPressed,
    ValueChanged<bool> onHighlightChanged,
    ButtonTextTheme textTheme,
    Color textColor,
    Color disabledTextColor,
    Color color,
    Color disabledColor,
    Color focusColor,
    Color hoverColor,
    Color highlightColor,
    Color splashColor,
    Brightness colorBrightness,
    EdgeInsetsGeometry padding,
    ShapeBorder shape,
    Clip clipBehavior,
    FocusNode focusNode,
    bool autofocus = false,
    MaterialTapTargetSize materialTapTargetSize,
    double paddingIconText = -1,// 图标和文字之间的间隔
    double paddingLabelToBorder= -1,// 文字到按钮边界的间隔
    Widget backgroundView,
    @required IconTextAlignment iconTextAlignment,
    @required Widget icon,
    @required Widget label,
  }) : assert(iconTextAlignment != IconTextAlignment.noIconOnlyText ? icon != null : true),
        assert(label != null),
        assert(autofocus != null),
        super(
        key: key,
        onPressed: onPressed,
        onHighlightChanged: onHighlightChanged,
        textTheme: textTheme,
        textColor: textColor,
        disabledTextColor: disabledTextColor,
        color: color,
        disabledColor: disabledColor,
        focusColor: focusColor,
        hoverColor: hoverColor,
        highlightColor: highlightColor,
        splashColor: splashColor,
        colorBrightness: colorBrightness,
        padding: padding,
        shape: shape,
        clipBehavior: clipBehavior,
        focusNode: focusNode,
        autofocus: autofocus,
        materialTapTargetSize: materialTapTargetSize,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            backgroundView != null ? backgroundView : Container(),
            iconTextAlignment == IconTextAlignment.iconLeftTextRight ? Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                icon,
                SizedBox(width: paddingIconText < 0 ? 8 : paddingIconText),
                label,
              ],
            ) : iconTextAlignment == IconTextAlignment.iconRightTextLeft ? Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                label,
                SizedBox(width: paddingIconText < 0 ? 8 : paddingIconText),
                icon,
              ],
            ) : iconTextAlignment == IconTextAlignment.iconTopTextBottom ? Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                icon,
                SizedBox(height:paddingIconText < 0 ? 8 : paddingIconText),
                label,
                SizedBox(height:paddingLabelToBorder < 0 ? 4 : paddingLabelToBorder),
              ],
            ) :  iconTextAlignment == IconTextAlignment.iconBottomTextTop ? Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height:paddingLabelToBorder < 0 ? 4 : paddingLabelToBorder),
                label,
                SizedBox(height:paddingIconText < 0 ? 8 : paddingIconText),
                icon,
              ],
            ) : label,
          ],
        ),
      );

}
