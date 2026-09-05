import 'package:flutter/widgets.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:slipwise/core/constants/constants.dart';

/// Smooth, bouncy spawn-in animation:
/// Fades in, pops up slightly from 0.85 scale with an elastic overshoot,
/// and glides up from just below rest position.
const List<AnimateEffect<dynamic>> kToastAnimateIn = [
  FadeEffect(
    begin: 0.0,
    end: 1.0,
    duration: Duration(milliseconds: 250),
    curve: Curves.easeOut,
  ),
  ScaleEffect(
    begin: Offset(0.85, 0.85),
    end: Offset(1.0, 1.0),
    duration: Duration(milliseconds: 250),
    curve: Curves.easeOutBack,
  ),
  SlideEffect(
    begin: Offset(0, 0.35),
    end: Offset.zero,
    duration: Duration(milliseconds: 250),
    curve: Curves.easeOutCubic,
  ),
];

/// Elegant spawn-out animation:
/// Fades out, shrinks slightly, and drifts downward.
const List<AnimateEffect<dynamic>> kToastAnimateOut = [
  FadeEffect(
    begin: 1.0,
    end: 0.0,
    duration: Duration(milliseconds: 200),
    curve: Curves.easeIn,
  ),
  ScaleEffect(
    begin: Offset(1.0, 1.0),
    end: Offset(0.9, 0.9),
    duration: Duration(milliseconds: 200),
    curve: Curves.easeInCubic,
  ),
  SlideEffect(
    begin: Offset.zero,
    end: Offset(0, 0.25),
    duration: Duration(milliseconds: 200),
    curve: Curves.easeInCubic,
  ),
];

/// Centralized toast helper and BuildContext extension.
///
/// Ensures all toasts share the single app-wide duration defined in
/// [UiConstants.toastDuration] and the smooth spawn-in / spawn-out animations.
class AppToast {
  static void show(
    BuildContext context, {
    String? title,
    Widget? titleWidget,
    String? description,
    Widget? descriptionWidget,
    Duration duration = UiConstants.toastDuration,
    List<AnimateEffect<dynamic>>? animateIn,
    List<AnimateEffect<dynamic>>? animateOut,
    Widget? action,
  }) {
    ShadToaster.of(context).show(
      ShadToast(
        duration: duration,
        animateIn: animateIn ?? kToastAnimateIn,
        animateOut: animateOut ?? kToastAnimateOut,
        title: titleWidget ?? (title != null ? Text(title) : null),
        description:
            descriptionWidget ??
            (description != null ? Text(description) : null),
        action: action,
      ),
    );
  }

  static void error(
    BuildContext context, {
    String? title,
    Widget? titleWidget,
    String? description,
    Widget? descriptionWidget,
    Duration duration = UiConstants.toastDuration,
    List<AnimateEffect<dynamic>>? animateIn,
    List<AnimateEffect<dynamic>>? animateOut,
    Widget? action,
  }) {
    ShadToaster.of(context).show(
      ShadToast.destructive(
        duration: duration,
        animateIn: animateIn ?? kToastAnimateIn,
        animateOut: animateOut ?? kToastAnimateOut,
        title: titleWidget ?? (title != null ? Text(title) : null),
        description:
            descriptionWidget ??
            (description != null ? Text(description) : null),
        action: action,
      ),
    );
  }
}

extension AppToastContextX on BuildContext {
  void showToast({
    String? title,
    Widget? titleWidget,
    String? description,
    Widget? descriptionWidget,
    Duration duration = UiConstants.toastDuration,
    List<AnimateEffect<dynamic>>? animateIn,
    List<AnimateEffect<dynamic>>? animateOut,
    Widget? action,
  }) => AppToast.show(
    this,
    title: title,
    titleWidget: titleWidget,
    description: description,
    descriptionWidget: descriptionWidget,
    duration: duration,
    animateIn: animateIn,
    animateOut: animateOut,
    action: action,
  );

  void showErrorToast({
    String? title,
    Widget? titleWidget,
    String? description,
    Widget? descriptionWidget,
    Duration duration = UiConstants.toastDuration,
    List<AnimateEffect<dynamic>>? animateIn,
    List<AnimateEffect<dynamic>>? animateOut,
    Widget? action,
  }) => AppToast.error(
    this,
    title: title,
    titleWidget: titleWidget,
    description: description,
    descriptionWidget: descriptionWidget,
    duration: duration,
    animateIn: animateIn,
    animateOut: animateOut,
    action: action,
  );
}
