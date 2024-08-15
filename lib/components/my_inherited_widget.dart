import 'package:flutter/material.dart';

class MyInheritedWidget extends InheritedWidget {
  final BoxConstraints constraints;

  const MyInheritedWidget({
    super.key,
    required this.constraints,
    required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) {
    return oldWidget.constraints != constraints;
  }

  static MyInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
  }
}
