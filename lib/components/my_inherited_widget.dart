import 'package:flutter/material.dart';

class MyInheritedWidget extends InheritedWidget {
  final BoxConstraints constraints;

  const MyInheritedWidget({
    super.key,
    required this.constraints,
    required super.child,
  });

  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) {
    return oldWidget.constraints != constraints;
  }

  static MyInheritedWidget? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
  }
}
