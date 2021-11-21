import 'package:flutter/material.dart';
import 'package:uikit/dropwidget/async_input_drop.dart';

class AsyncDropExample extends StatelessWidget {
  const AsyncDropExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AsyncInputDrop(
      asyncLoad: (c) {
        return c.future;
      },
      controller: TextEditingController(),
      itemWidget: (List<dynamic> list) {

        return
      },
    );
  }
}
