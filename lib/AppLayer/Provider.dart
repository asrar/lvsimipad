import 'package:lvsimipad/AppLayer/Overseer.dart';
import 'package:flutter/material.dart';

class Provider extends InheritedWidget {
   final Overseer data;

  Provider({required Widget child,required this.data}) : super( child:child);

  static Overseer of(BuildContext context) {

    return (context.dependOnInheritedWidgetOfExactType<Provider>())!.data;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}
