import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// This is a modification of [AlertDialog]. A lot of modifications was made. The goal is
/// to retain the dialog feel and look while adding the close IconButton
class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    Key? key,
    this.title,
    this.titlePadding,
    this.onCancelPress,
    this.contentPadding = EdgeInsets.zero,
    this.expanded = false,
    this.fullscreen = false,
    required this.content,
  }) : super(key: key);

  final Widget? title;
  final EdgeInsetsGeometry? titlePadding;
  final Widget content;
  final EdgeInsetsGeometry contentPadding;
  final VoidCallback? onCancelPress;
  final bool expanded;
  final bool fullscreen;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];

    if (title != null && titlePadding != null) {
      children.add(new Padding(
        padding: titlePadding!,
        child: new DefaultTextStyle(
          style: Theme.of(context).textTheme.headline6!,
          child: new Semantics(child: title, namesRoute: true),
        ),
      ));
    }

    children.add(new Flexible(
      child: new Padding(
        padding: contentPadding,
        child: new DefaultTextStyle(
          style: Theme.of(context).textTheme.subtitle1!,
          child: content,
        ),
      ),
    ));

    return buildContent(context, children);
  }

  Widget buildContent(context, List<Widget> children) {
    Widget widget;
    if (fullscreen) {
      widget = new Material(
        color: Theme.of(context).colorScheme.background,
        child: new Container(
          //height: double.infinity,
            child: onCancelPress == null
                ? new Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      //vertical: 20.0,
                    ),
                    child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: children),
                  )
                : new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Align(
                        alignment: Alignment.topRight,
                        child: new IconButton(
                          icon: new Icon(Icons.close),
                          onPressed: onCancelPress,
                          color: Theme.of(context).colorScheme.secondary,
                          padding: const EdgeInsets.all(15.0),
                          iconSize: 30.0,
                        ),
                      ),
                      new Expanded(
                          child: new Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: new Column(
                          children: children,
                        ),
                      ))
                    ],
                  )),
      );
    } else {
      var body = new Material(
        type: MaterialType.card,
        borderRadius: new BorderRadius.circular(10.0),
        color: Theme.of(context).colorScheme.background,
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      );
      var child = onCancelPress == null
          ? body
          : new Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                new Container(
                  margin: const EdgeInsets.all(10.0),
                  child: new IconButton(
                      color: Theme.of(context).colorScheme.secondary,
                      iconSize: 30.0,
                      padding: const EdgeInsets.all(3.0),
                      icon: const Icon(
                        Icons.cancel,
                      ),
                      onPressed: onCancelPress),
                ),
                new Flexible(child: body),
              ],
            );
      widget = new CustomDialog(
        child: child,
        expanded: expanded,
        isFullScreen: fullscreen,
      );
    }
    return widget;
  }
}

/// This is a modification of [Dialog]. The only modification is increasing the
/// elevation and changing the Material type.
class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key? key,
    required this.child,
    required this.expanded,
    required this.isFullScreen,
    this.insetAnimationDuration = const Duration(milliseconds: 100),
    this.insetAnimationCurve = Curves.decelerate,
  }) : super(key: key);

  final Widget child;
  final Duration insetAnimationDuration;
  final Curve insetAnimationCurve;
  final bool expanded;
  final bool isFullScreen;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: isFullScreen
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Material(
        elevation: 50.0,
        type: MaterialType.transparency,
        child: child,
      ),
    );
  }
}
