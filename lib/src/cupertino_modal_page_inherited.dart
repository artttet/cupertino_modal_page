import 'package:flutter/widgets.dart';
import 'cupertino_modal_page.dart';

class CupertinoModalPageInherited extends InheritedWidget {
  const CupertinoModalPageInherited({super.key, required super.child, required this.data});

  final CupertinoModalPageState data;

  static CupertinoModalPageInherited? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CupertinoModalPageInherited>();
  }

  @override
  bool updateShouldNotify(CupertinoModalPageInherited oldWidget) => true;
}
