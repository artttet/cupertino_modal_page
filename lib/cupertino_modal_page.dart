library;

import 'package:flutter/widgets.dart';
import 'src/cupertino_modal_page_inherited.dart';

export 'src/cupertino_modal_page.dart';

Future<T?> showCupetinoModalPage<T>(BuildContext context, WidgetBuilder builder) {
  final state = CupertinoModalPageInherited.of(context)?.data;
  if (state == null) {
    throw Exception(
      'CupertinoModalPage is not present in the current widget tree. Make sure it is properly inserted into the widget hierarchy.',
    );
  }

  return state.show<T>(context, builder);
}
